####################################################
#               EKS Cluster Setup                  #
####################################################

module "aws_vpc" {
  source                        = "git@github.com:artdotcom/terraform-module-eks-vpc.git"
  cluster_name                  = var.aws_eks_cluster_name
  aws_vpc_cidr_block            = var.aws_vpc_cidr_block
  aws_public_subnet_cidr_block  = var.aws_public_subnet_cidr_block
  aws_private_subnet_cidr_block = var.aws_private_subnet_cidr_block
}

module "aws_security" {
  source                  = "git@github.com:artdotcom/terraform-module-eks-security.git"
  cluster_name            = var.aws_eks_cluster_name
  aws_vpc_id              = module.aws_vpc.aws_vpc_id
  aws_vpc_public_subnets  = module.aws_vpc.vpc_private_subnet_id
  aws_vpc_private_subnets = module.aws_vpc.vpc_public_subnet_id
  my_cidr_block           = var.my_cidr_block
}

module "aws_iam" {
  source       = "git@github.com:artdotcom/terraform-module-eks-iam.git"
  cluster_name = var.aws_eks_cluster_name
}

module "aws_ec2" {
  source         = "git@github.com:artdotcom/terraform-module-eks-bastion.git"
  instance_type  = "t2.micro"
  vpc_id         = module.aws_vpc.aws_vpc_id
  security_group = module.aws_security.sec_bastion_sg_id
  subnet         = module.aws_vpc.vpc_public_subnet_bastion
}

module "aws_eks" {
  source                           = "git@github.com:artdotcom/terraform-module-eks-cluster.git"
  cluster_name                     = var.aws_eks_cluster_name
  iam_master_role_arn              = module.aws_iam.iam_master_role_arn
  iam_nodes_role_arn               = module.aws_iam.iam_nodes_role_arn
  sec_master_sg_id                 = module.aws_security.sec_master_sg_id
  sec_nodes_sg_id                  = module.aws_security.sec_nodes_sg_id
  iam_master_cluster_attachment_id = module.aws_iam.iam_master_cluster_attachment_id
  iam_master_svc_attachment_id     = module.aws_iam.iam_master_svc_attachment_id
  iam_node_instance_profile        = module.aws_iam.iam_node_instance_profile
  vpc_subnet_id                    = [module.aws_vpc.vpc_private_subnet_id, module.aws_vpc.vpc_public_subnet_id]
  wait_for_resources               = [module.aws_vpc.igw_id, module.aws_iam.iam_master_cluster_attachment_id, module.aws_iam.iam_master_svc_attachment_id]
}