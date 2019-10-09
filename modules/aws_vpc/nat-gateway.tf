resource "aws_nat_gateway" "nat-gateway" {
  count         = length(aws_subnet.public_subnet)
  allocation_id = aws_eip.nat-gateway-eip.*.id[count.index]
  subnet_id     = aws_subnet.public_subnet.*.id[count.index]

  tags = {
    Name = "${var.cluster_name}-${data.aws_availability_zones.available.names[count.index]}"
  }

  depends_on = ["aws_internet_gateway.igw"]
}