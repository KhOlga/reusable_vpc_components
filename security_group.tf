resource "aws_security_group" "public_security_group" {
  name        = "public_allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = aws_vpc.olha-vpc.id

  dynamic "ingress" {

    for_each = var.inbound_rule

    content {
      description = ingress.key
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = ingress.value.cidr_blocks
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }

  tags = {
    Name = var.sg_name["public"]
  }
}

resource "aws_security_group" "private_security_group" {
  name        = "private_allow_tls"
  description = "Allow TLS inbound traffic from private server"
  vpc_id      = aws_vpc.olha-vpc.id

  ingress {
    description = "TLS from Internet"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [aws_subnet.subnet["public_subnet"].cidr_block]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_name["private"]
  }
}
