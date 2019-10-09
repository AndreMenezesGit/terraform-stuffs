output "sec_master_sg_id" {
  value = aws_security_group.art-eks-master.*.id
}

output "sec_nodes_sg_id" {
  value = [aws_security_group.art-eks-node.*.id]
}

output "sec_bastion_sg_id" {
  value = aws_security_group.eks-bastion-host.*.id
}