resource "aws_cloudwatch_log_group" "art-eks-logs-group" {
  name              = "/aws/eks/${var.cluster_name}/cluster"
  retention_in_days = 7
}

resource "null_resource" "depends_on" {
  triggers = {
    instance = join(",", var.wait_for_resources)
  }
}

resource "aws_eks_cluster" "art-eks" {
  name     = var.cluster_name
  role_arn = var.iam_master_role_arn
  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "scheduler",
    "controllerManager"
  ]

  vpc_config {
    security_group_ids      = flatten([var.sec_master_sg_id])
    subnet_ids              = flatten([var.vpc_subnet_id])
    endpoint_private_access = var.endpoint_private_access
    endpoint_public_access  = var.endpoint_public_access
  }

  depends_on = []
}
