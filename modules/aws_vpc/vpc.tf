data "aws_availability_zones" "available" {}

resource "aws_vpc" "vpc" {

  cidr_block           = var.aws_vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    "Name"                                      = var.cluster_name,
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
  }
}
