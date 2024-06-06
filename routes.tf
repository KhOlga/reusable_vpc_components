resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.olha-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = var.public_rtb
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.subnet["public_subnet"].id
  route_table_id = aws_route_table.public_route.id
}

resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.olha-vpc.id

  tags = {
    Name = var.private_rtb
  }
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.subnet["private_subnet"].id
  route_table_id = aws_route_table.private_route.id
}
