# 07_ng
resource "aws_eip" "jinwoo-eip-ng" {
  vpc = true
}

resource "aws_nat_gateway" "jinwoo-ng" {
  allocation_id = aws_eip.jinwoo-eip-ng.id
  subnet_id = aws_subnet.jinwoo-pub[0].id
  tags = {
    "Name" = "${var.name}-ng"
  }
  depends_on = [
    aws_internet_gateway.jinwoo-ig
  ]
}

# 08_ngrt
resource "aws_route_table" "jinwoo-ngrt" {
  vpc_id = aws_vpc.jinwoo_vpc.id

  route {
      cidr_block = var.cidr_route
      gateway_id = aws_nat_gateway.jinwoo-ng.id
  }
  tags = {
    "Name" = "${var.name}-ngrt"
  }
}

# 09_ngass
resource "aws_route_table_association" "jinwoo-ngass" {
  count = length(var.cidr_public)
  subnet_id = aws_subnet.jinwoo-pri[count.index].id
  route_table_id = aws_route_table.jinwoo-ngrt.id
}