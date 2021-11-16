# 04_ig
resource "aws_internet_gateway" "jinwoo-ig" {
  vpc_id = aws_vpc.jinwoo_vpc.id
  tags = {
    "Name" = "${var.name}-ig"
  }
}

# 05_rt
resource "aws_route_table" "jinwoo-rt" {
  vpc_id = aws_vpc.jinwoo_vpc.id

  route {
      cidr_block = var.cidr_route
      gateway_id = aws_internet_gateway.jinwoo-ig.id
  }

  tags = {
    "Name" = "${var.name}-rt"
  }
}

# 06_rtass
resource "aws_route_table_association" "jinwoo_rtass_pub" {
  count = length(var.cidr_public)
  subnet_id = aws_subnet.jinwoo-pub[count.index].id 
  route_table_id = aws_route_table.jinwoo-rt.id
}