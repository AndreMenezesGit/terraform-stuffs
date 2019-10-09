variable "aws_region" {
  type        = "string"
  description = "The AWS region of the resources"
  default     = "us-east-1"
}

variable "aws_eks_cluster_name" {
  type        = "string"
  description = "Cluster name, this is EKS cluster name. The cluster name is used in Control Plane and resources TAG's when this resources are used by EKS"
  default     = "nonprod-eks"
}

variable "aws_vpc_cidr_block" {
  type        = "string"
  description = "Network range for VPC"
  default     = "172.28.0.0/16"
}

variable "aws_public_subnet_cidr_block" {
  type        = "list"
  description = "Subnets range for public subnets"
  default     = ["172.28.16.0/20", "172.28.32.0/20", "172.28.48.0/20"]
}

variable "aws_private_subnet_cidr_block" {
  type        = "list"
  description = "Subnets range for private subnets"
  default     = ["172.28.64.0/20", "172.28.80.0/20", "172.28.96.0/20"]
}

variable "my_cidr_block" {
  type        = "string"
  description = "My network IP range for VPN use or security group access"
  default     = "0.0.0.0/0"
}