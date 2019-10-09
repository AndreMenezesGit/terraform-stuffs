resource "aws_security_group" "art-eks-master" {
  name        = "${var.cluster_name}-master"
  description = "Cluster communication with worker nodes"
  vpc_id      = var.aws_vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.cluster_name}-master"
  }
}

resource "aws_security_group_rule" "art-eks-master-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.art-eks-master.id
  source_security_group_id = aws_security_group.art-eks-node.id
  to_port                  = 443
  type                     = "ingress"
}