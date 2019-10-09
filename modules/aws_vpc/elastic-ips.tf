resource "aws_eip" "nat-gateway-eip" {
  count = length(aws_subnet.public_subnet)
  vpc   = true

  tags = {
    Name = "${var.cluster_name}-${data.aws_availability_zones.available.names[count.index]}"
  }

  depends_on = ["aws_internet_gateway.igw"]
}