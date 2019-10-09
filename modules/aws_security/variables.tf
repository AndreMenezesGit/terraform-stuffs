variable "cluster_name" {
  type = "string"
}

variable "aws_vpc_id" {
  type = "string"
}

variable "aws_vpc_public_subnets" {
  type = "list"
}

variable "aws_vpc_private_subnets" {
  type = "list"
}

variable "my_cidr_block" {
  type = "string"
}