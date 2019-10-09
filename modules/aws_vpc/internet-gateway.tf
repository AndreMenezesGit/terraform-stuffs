resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = var.cluster_name
  }

  depends_on = ["aws_vpc.vpc"]
}