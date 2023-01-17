#----------------------------------------------------
## VPC 3
resource "aws_vpc" "vpc_3" {
  cidr_block       = var.vpc_cidr[2]
  enable_dns_hostnames = true
  
  tags = {
    Name = "vpc 3"
  }
}

#----------------------------------------------------
## Subnet
resource "aws_subnet" "vpc_3_private_subnet" {
  vpc_id     = aws_vpc.vpc_3.id
  cidr_block = "10.2.0.0/24"
  availability_zone = var.availability_zone[0]
  map_public_ip_on_launch = false

  tags = {
    "Name" = "vpc-3-private subnet"
  }
}

resource "aws_subnet" "vpc_3_public_subnet" {
  vpc_id     = aws_vpc.vpc_3.id
  cidr_block = "10.2.1.0/24"
  availability_zone = var.availability_zone[1]

  tags = {
    "Name" = "vpc-3-public-subnet"
  }
}

#----------------------------------------------------
## Route Table
resource "aws_route_table" "vpc-3-public-rt" {
  vpc_id = aws_vpc.vpc_3.id

  route {
    cidr_block = "0.0.0.0/0"
    transit_gateway_id = aws_ec2_transit_gateway.tgw.id
  }

  tags = {
    "Name" = "vpc-3-public-rt"
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.vpc_3_public_subnet.id
  route_table_id = aws_route_table.vpc-3-public-rt.id
}