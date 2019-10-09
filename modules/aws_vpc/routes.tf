resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Name"                                      = "public-${var.cluster_name}",
    "kubernetes.io/cluster/${var.cluster_name}" = "shared",
  }

  depends_on = ["aws_internet_gateway.igw"]
}

resource "aws_route_table_association" "public_rta" {
  count = length(var.aws_public_subnet_cidr_block)

  subnet_id      = aws_subnet.public_subnet.*.id[count.index]
  route_table_id = aws_route_table.public_rt.id

  depends_on = ["aws_route_table.public_rt"]
}

resource "aws_route_table" "private_rt" {
  count  = length(aws_nat_gateway.nat-gateway)
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.nat-gateway.*.id[count.index]
  }

  tags = {
    "Name"                                      = "private-${var.cluster_name}-${data.aws_availability_zones.available.names[count.index]}",
    "kubernetes.io/cluster/${var.cluster_name}" = "shared",
  }

  depends_on = ["aws_internet_gateway.igw"]
}

resource "aws_route_table_association" "private_rta" {
  count = length(var.aws_private_subnet_cidr_block)

  subnet_id      = aws_subnet.private_subnet.*.id[count.index]
  route_table_id = aws_route_table.private_rt.*.id[count.index]

  depends_on = ["aws_route_table.private_rt"]
}