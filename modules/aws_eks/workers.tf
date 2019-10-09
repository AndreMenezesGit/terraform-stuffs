data "aws_ami" "void-eks-worker" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.art-eks.version}-v*"]
  }

  most_recent = true
  owners      = [var.account_id]
}

data "aws_region" "current" {}

locals {
  void-node-userdata = <<USERDATA
    #!/bin/bash
    set -o xtrace
    /etc/eks/bootstrap.sh \
    --apiserver-endpoint '${aws_eks_cluster.art-eks.endpoint}' \
    --b64-cluster-ca '${aws_eks_cluster.art-eks.certificate_authority.0.data}' \
    '${var.cluster_name}'
    USERDATA
}

resource "aws_key_pair" "eks_workers" {
  key_name   = "${var.cluster_name}-nodes"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDFysXWT317W4fxM8FS0OLID6wndineO9v4ZFAj8qTVbA+ZCQ0kQAbo21X5w2ySyAh0uq/KeH6jae3RqjZeYidmEvVoOELRr9m0/D+UIheeLaI1j7gGOVnnrBESuDA6WCIfB5XN2ljOIi/8jnwh6KK61qWi0FdocsovLcMV4+KM3uCxNzdLcUeNP6U6mFxS6Gs4Q/zyHgeX1MO51tgpacuWbdabMmKN+Re4m/HtkMZeqWhths4AWcHjf6PVO8pdJITNQL/J/7RKtWd6Sjj4kbGpLkpjLUseBB5fogwGp0NT228qiNdCWxJnREEVNv3gXnaxqYLuTNCxLtXOjsjMHvtr gsilva@ac-gsilva-MAC-2.local"
}

resource "aws_launch_configuration" "art-eks-worker" {
  associate_public_ip_address = var.node_public_ip
  key_name                    = aws_key_pair.eks_workers.key_name
  iam_instance_profile        = var.iam_node_instance_profile
  image_id                    = data.aws_ami.void-eks-worker.id
  instance_type               = var.node_instance_type
  name_prefix                 = "${var.cluster_name}-"
  security_groups             = flatten([var.sec_nodes_sg_id])
  user_data_base64            = base64encode(local.void-node-userdata)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "void-eks-worker" {
  desired_capacity     = var.eks_node_count
  launch_configuration = aws_launch_configuration.art-eks-worker.id
  max_size             = var.eks_max_node_count
  min_size             = var.eks_min_node_count
  name                 = var.cluster_name
  vpc_zone_identifier  = flatten([var.vpc_subnet_id])

  tag {
    key                 = "Name"
    value               = var.cluster_name
    propagate_at_launch = true
  }

  tag {
    key                 = "kubernetes.io/cluster/${var.cluster_name}"
    value               = "owned"
    propagate_at_launch = true
  }
}
