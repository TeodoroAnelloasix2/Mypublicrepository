#vpc

resource "aws_vpc" "vpc_k0s" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "vpc_k0s"
  }
}


resource "aws_subnet" "pbl_subnet" {
  vpc_id                  = aws_vpc.vpc_k0s.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
  tags = {
    Name = "pubblic_subnet_k0s"
  }
}

resource "aws_subnet" "prvt_subnet" {
  vpc_id                  = aws_vpc.vpc_k0s.id
  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone       = "us-east-1a"
  tags = {
    Name = "private_subnet_k0s"
  }
}


resource "aws_internet_gateway" "igw_k0s" {
  vpc_id = aws_vpc.vpc_k0s.id
  tags = {
    Name = "igw-k0s"
  }
}




resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc_k0s.id
  route {
    cidr_block = aws_vpc.vpc_k0s.cidr_block # Destination
    gateway_id = "local"
  }
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }

  tags = {
    Name = "private-rt"
  }
}


resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc_k0s.id
  route {
    cidr_block = "0.0.0.0/0" # Destination
    gateway_id = aws_internet_gateway.igw_k0s.id  # Target
  }
  tags = {
    Name = "public-rt"
  }
}

resource "aws_route_table_association" "pblc-rt-association" {
  subnet_id = aws_subnet.pbl_subnet.id
  route_table_id = aws_route_table.public-rt.id
}

resource "aws_route_table_association" "prvt-rt-association" {
  subnet_id = aws_subnet.prvt_subnet.id
  route_table_id = aws_route_table.private-rt.id
}


# To reach internet on private subnet

resource "aws_eip" "nat_eip" {
  domain = "vpc"
  tags = {
    Name="nat-eip"
  }
}
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id = aws_subnet.pbl_subnet.id
  tags = {
    Name = "nat-gateway"
  }
}