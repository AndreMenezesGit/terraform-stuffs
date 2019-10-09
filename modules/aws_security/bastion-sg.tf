resource "aws_security_group" "eks-bastion-host" {
  name        = "eks-bastion-host"
  description = "Security group for bastion host to interact and deploy EKS infra"
  vpc_id      = var.aws_vpc_id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ var.my_cidr_block ]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-bastion-host"
  }
}

