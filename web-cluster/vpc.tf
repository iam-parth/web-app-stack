resource "aws_vpc" "app_vpc" {
  cidr_block       = var.app-cidr
  instance_tenancy = "default"
  tags = {
    Name        = "app-vpc-${var.dev-env}"
    Terraform   = "true"
    Environment = var.dev-env
  }
}

resource "aws_subnet" "app-private" {
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = var.app-private
  map_public_ip_on_launch = false
  tags = {
    Name        = "app-private-${var.dev-env}"
    Terraform   = "true"
    Environment = var.dev-env
  }
}

resource "aws_subnet" "app-public" {
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = var.app-public
  map_public_ip_on_launch = true
  tags = {
    Name        = "app-public-${var.dev-env}"
    Terraform   = "true"
    Environment = var.dev-env
  }
}

resource "aws_eip" "nat" {
  vpc = true
}

resource "aws_nat_gateway" "app-nat-gw" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.app-public.id
  tags = {
    Name        = "app-nat-gw-${var.dev-env}"
    Terraform   = "true"
    Environment = var.dev-env
  }
}

resource "aws_route_table" "app-private-routetable" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name        = "app-private-routetable-${var.dev-env}"
    Terraform   = "true"
    Environment = var.dev-env
  }
}

resource "aws_route" "app-private-route" {
  route_table_id         = aws_route_table.app-private-routetable.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.app-nat-gw.id
}

resource "aws_route_table_association" "app-private-association" {
  subnet_id      = aws_subnet.app-private.id
  route_table_id = aws_route_table.app-private-routetable.id
}

resource "aws_internet_gateway" "app-gw" {
  vpc_id = aws_vpc.app_vpc.id
}

resource "aws_route_table" "app-public-routetable" {
  vpc_id = aws_vpc.app_vpc.id
  tags = {
    Name        = "app-public-routetable-${var.dev-env}"
    Terraform   = "true"
    Environment = var.dev-env
  }
}

resource "aws_route" "app-public-route" {
  route_table_id         = aws_route_table.app-public-routetable.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.app-gw.id
}

resource "aws_route_table_association" "app-public-association" {
  subnet_id      = aws_subnet.app-public.id
  route_table_id = aws_route_table.app-public-routetable.id
}

resource "aws_subnet" "rds-subnet-1" {
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = var.rds-private-1
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"
  tags = {
    Name        = "app-private-${var.dev-env}"
    Terraform   = "true"
    Environment = var.dev-env
  }
}

resource "aws_subnet" "rds-subnet-2" {
  vpc_id                  = aws_vpc.app_vpc.id
  cidr_block              = var.rds-private-2
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1b"
  tags = {
    Name        = "app-private-${var.dev-env}"
    Terraform   = "true"
    Environment = var.dev-env
  }
}