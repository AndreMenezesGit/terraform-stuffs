resource "aws_subnet" "public_subnet" {
  count             = length(var.aws_public_subnet_cidr_block)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = var.aws_public_subnet_cidr_block[count.index]
  vpc_id            = aws_vpc.vpc.id

  tags = {
    "Name"                                      = "public-${var.cluster_name}-${data.aws_availability_zones.available.names[count.index]}",
    "kubernetes.io/cluster/${var.cluster_name}" = "shared",
  }

  depends_on = ["aws_vpc.vpc", "aws_internet_gateway.igw"]
}

resource "aws_subnet" "private_subnet" {
  count             = length(var.aws_private_subnet_cidr_block)
  availability_zone = data.aws_availability_zones.available.names[count.index]
  cidr_block        = var.aws_private_subnet_cidr_block[count.index]
  vpc_id            = aws_vpc.vpc.id

  tags = {
    "Name"                                      = "private-${var.cluster_name}-${data.aws_availability_zones.available.names[count.index]}",
    "kubernetes.io/cluster/${var.cluster_name}" = "shared",
  }

  depends_on = ["aws_vpc.vpc", "aws_internet_gateway.igw"]
}
