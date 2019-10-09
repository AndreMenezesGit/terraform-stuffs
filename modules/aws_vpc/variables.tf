variable "aws_vpc_cidr_block" {
  type = "string"
}

variable "aws_public_subnet_cidr_block" {
  type = "list"
}

variable "aws_private_subnet_cidr_block" {
  type = "list"
}

variable "cluster_name" {
  type = "string"
}
