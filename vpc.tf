resource "aws_vpc" "olha-vpc" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "subnet" {

  vpc_id                  = aws_vpc.olha-vpc.id
  cidr_block              = each.value.cidr_block
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = {
    Name = each.value.name
  }

  for_each = var.subnets
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.olha-vpc.id
  tags = {
    Name = var.igw
  }
}
