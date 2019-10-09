output "aws_vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_public_subnet_id" {
  value = aws_subnet.public_subnet.*.id
}

output "vpc_private_subnet_id" {
  value = aws_subnet.private_subnet.*.id
}

output "public_route_table_id" {
  value = aws_route_table.public_rt.id
}

output "igw_id" {
  value = aws_internet_gateway.igw.id
}

output "vpc_public_subnet_bastion" {
  value = aws_subnet.public_subnet.0.id
}