data "external" "aws_iam_authenticator" {
  program = ["sh", "-c", "aws-iam-authenticator token -i ${var.cluster_name} | jq -r -c .status"]
}

provider "kubernetes" {
  host                   = aws_eks_cluster.art-eks.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.art-eks.certificate_authority.0.data)
  token                  = data.external.aws_iam_authenticator.result.token
  load_config_file       = false
  version                = "~> 1.5"
}

resource "kubernetes_config_map" "aws_auth" {
  metadata {
    name      = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = <<EOF
    - rolearn: ${var.iam_nodes_role_arn}
      username: system:node:{{EC2PrivateDNSName}}
      groups:
        - system:bootstrappers
        - system:nodes
    - rolearn: arn:aws:iam::538851594358:user/andremenezes
      username: amenezes
      groups:
        - system:masters
EOF
  }

  depends_on = [
    "aws_eks_cluster.art-eks",
    "aws_autoscaling_group.void-eks-worker",
  ]

  provisioner "local-exec" {
    command = "sleep 30"
  }
}

resource "local_file" "eks_kubeconfig" {
  content = <<KUBECONFIG
apiVersion: v1
clusters:
- cluster:
    server: ${aws_eks_cluster.art-eks.endpoint}
    certificate-authority-data: ${aws_eks_cluster.art-eks.certificate_authority.0.data}
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: aws
  name: aws
current-context: aws
kind: Config
preferences: {}
users:
- name: aws
  user:
    exec:
      apiVersion: client.authentication.k8s.io/v1alpha1
      command: aws-iam-authenticator
      args:
        - "token"
        - "-i"
        - "${var.cluster_name}"
KUBECONFIG

  filename = "./configs/kubeconfig-eks-${aws_eks_cluster.art-eks.name}"
}
