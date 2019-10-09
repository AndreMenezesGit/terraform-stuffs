output "iam_master_role_arn" {
  value = aws_iam_role.eks-master-role.arn
}

output "iam_nodes_role_arn" {
  value = aws_iam_role.eks-nodes-role.arn
}

output "iam_master_cluster_attachment_id" {
  value = aws_iam_role_policy_attachment.void-eks-master-AmazonEKSClusterPolicy.id
}

output "iam_master_svc_attachment_id" {
  value = aws_iam_role_policy_attachment.void-eks-master-AmazonEKSServicePolicy.id
}

output "iam_node_instance_profile" {
  value = aws_iam_instance_profile.void-eks-node.name
}
