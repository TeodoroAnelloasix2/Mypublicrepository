# Create VPC
resource "aws_vpc" "wa1_vpc" {
  cidr_block           = var.vpc_config.cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.vpc_config.name
  }
}


# Create Public Subnet
resource "aws_subnet" "wa1_public_sbnt" {
  vpc_id                  = aws_vpc.wa1_vpc.id
  cidr_block              = var.public_sbnt_config.cidr
  map_public_ip_on_launch = var.public_sbnt_config.maping
  tags = {
    Name = var.public_sbnt_config.name
  }
}

#Create internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.wa1_vpc.id
  tags = {
    Name = var.config_igtw.name
  }
}

# Create route table
resource "aws_route_table" "wa1_rt" {
  vpc_id = aws_vpc.wa1_vpc.id
  route {
    cidr_block = var.rt_cidr
    gateway_id = aws_internet_gateway.igw.id
  }
}

#Route Table Association
resource "aws_route_table_association" "rt-association" {
  subnet_id      = aws_subnet.wa1_public_sbnt.id
  route_table_id = aws_route_table.wa1_rt.id
}

