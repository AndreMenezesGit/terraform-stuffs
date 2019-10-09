variable "instance_type" {
  type        = "string"
  description = "Amazon instance type"
  default     = "t2.micro"
}

variable "vpc_id" {
  type        = "string"
  description = "VPC id provide by VPC module"
  default     = ""
}

variable "security_group" {
  type        = "list"
  description = "Security group ID for bastion host provide by Security module"
  default     = []
}

variable "subnet" {
  type        = "string"
  description = "A public subnet received from VPC module"
  default     = ""
}