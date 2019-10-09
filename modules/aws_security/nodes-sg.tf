resource "aws_security_group" "art-eks-node" {
  name        = "${var.cluster_name}-nodes"
  description = "Security group for all nodes in the cluster"
  vpc_id      = var.aws_vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name"                                      = "${var.cluster_name}-nodes",
    "kubernetes.io/cluster/${var.cluster_name}" = "owned",
  }
}

resource "aws_security_group_rule" "art-eks-node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.art-eks-node.id
  source_security_group_id = aws_security_group.art-eks-node.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "art-eks-node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.art-eks-node.id
  source_security_group_id = aws_security_group.art-eks-master.id
  to_port                  = 65535
  type                     = "ingress"
}
