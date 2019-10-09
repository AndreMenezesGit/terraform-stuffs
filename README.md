# Terraform EKS Cluster

To create new EKS cluster set the configuration of the variables in the variables.tf

This the variables list and your default values. Change de values according to your cluster particularities

|Name   |Description   |Type   |Default   |Required   |
|---|---|---|---|---|
|aws_region   |The AWS region of the resources   |string   |us-east-1   |yes   |
|aws_eks_cluster_name   |Cluster name, this is EKS cluster name. The cluster name is used in Control Plane and resources TAG's when this resources are used by EKS   |string   |nonprod-eks   |yes   |
|aws_vpc_cidr_block   |Network range for VPC   |string   |172.28.0.0/16   |yes   |
|aws_public_subnet_cidr_block   |Subnets range for public subnets   |list   |172.28.16.0/20 172.28.32.0/20 172.28.48.0/20   |yes   |
|aws_private_subnet_cidr_block   |Subnets range for private subnets   |list   |172.28.64.0/20 172.28.80.0/20 172.28.96.0/20   |yes   |

Before applying your plan after change the variables you need to provide the remote backend. To more details see: https://github.com/artdotcom/terraform-remote-backend
