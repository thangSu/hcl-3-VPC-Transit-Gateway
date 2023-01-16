#----------------------------------------------------
## VPC
resource "aws_vpc" "vpc_1" {
  cidr_block       = var.vpc_cidr[0]
  enable_dns_hostnames = true
  
  tags = {
    Name = "vpc 1"
  }
}

#----------------------------------------------------
## Subnet
resource "aws_subnet" "vpc_1_private_subnet" {
  vpc_id     = aws_vpc.vpc_1.id
  cidr_block = "10.0.0.0/24"
  availability_zone = var.availability_zone[0]

  tags = {
    "Name" = "vpc-1-private-subnet"
  }
}

resource "aws_subnet" "vpc_1_public_subnet" {
  vpc_id     = aws_vpc.vpc_1.id
  cidr_block = "10.0.1.0/24"
  availability_zone = var.availability_zone[1]

  tags = {
    "Name" = "vpc-1-public-subnet"
  }
}

#----------------------------------------------------
## Internet Gateway
resource "aws_internet_gateway" "vpc_1_igw" {
  vpc_id = aws_vpc.vpc_1.id

  tags = {
    "Name" = "vpc-1-igw"
  }
}

#----------------------------------------------------
## Route Table
resource "aws_route_table" "vpc-1-public-rt" {
  vpc_id = aws_vpc.vpc_1.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_1_igw.id
  }

  tags = {
    "Name" = "vpc-1-public-rt"
  }
}

resource "aws_route_table_association" "vpc_1_public_asso" {
  subnet_id      = aws_subnet.vpc_1_public_subnet.id
  route_table_id = aws_route_table.vpc-1-public-rt.id
}