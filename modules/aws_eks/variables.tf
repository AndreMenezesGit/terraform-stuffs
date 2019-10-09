variable "cluster_name" {
  type = "string"
}

variable "iam_master_role_arn" {
  type = "string"
}

variable "iam_nodes_role_arn" {
  type = "string"
}

variable "eks_kube_version" {
  type    = "string"
  default = "1.13"
}

variable "eks_version" {
  type    = "string"
  default = "eks.4"
}

variable "sec_master_sg_id" {
  type = "list"
}

variable "sec_nodes_sg_id" {
  type = "list"
}

variable "vpc_subnet_id" {
  type = "list"
}

variable "iam_master_cluster_attachment_id" {
  type = "string"
}

variable "iam_master_svc_attachment_id" {
  type = "string"
}

variable "wait_for_resources" {
  type = "list"
}

variable "account_id" {
  type    = "string"
  default = "602401143452"
}

variable "node_public_ip" {
  type    = "string"
  default = "true"
}

variable "iam_node_instance_profile" {
  type = "string"
}

variable "node_instance_type" {
  type    = "string"
  default = "m4.large"
}

variable "eks_node_count" {
  type    = "string"
  default = "2"
}

variable "eks_max_node_count" {
  type    = "string"
  default = "2"
}

variable "eks_min_node_count" {
  type    = "string"
  default = "1"
}

variable "endpoint_private_access" {
  type        = "string"
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled."
  default     = "false"
}

variable "endpoint_public_access" {
  type        = "string"
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  default     = "true"
}