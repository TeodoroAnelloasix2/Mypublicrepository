#vpc
resource "aws_vpc" "vpc_ansible" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.vpc_name
  }
}


# Public subnet

resource "aws_subnet" "pblc_subnet" {
  vpc_id                  = aws_vpc.vpc_ansible.id
  cidr_block              = var.pblc_sbnt_cidr
  map_public_ip_on_launch = true
  availability_zone       = var.pblc_subnt_az
  tags = {
    Name = var.pblc_sbnt_name
  }
}

# Internet gateway

resource "aws_internet_gateway" "igw_ansible" {
  vpc_id = aws_vpc.vpc_ansible.id
  tags = {
    Name = var.igw_name
  }
}

# Route table

resource "aws_route_table" "rt_ansible" {
  vpc_id = aws_vpc.vpc_ansible.id
  route {
    cidr_block = var.rt_cidr
    gateway_id = aws_internet_gateway.igw_ansible.id
  }
}

# Route table association

resource "aws_route_table_association" "rt-association" {
  subnet_id      = aws_subnet.pblc_subnet.id
  route_table_id = aws_route_table.rt_ansible.id
}