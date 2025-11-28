resource "aws_vpc" "vpc_virginia" {
  cidr_block = var.cidr_virginia
  tags = {
    manteiner = var.tags_virginia.Manteiner
    env       = var.tags_virginia.Environment
    Name=var.tags_virginia.Vpc_Name
  }
}

resource "aws_subnet" "public_subnet_virginia" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.public_subnet_ip
  map_public_ip_on_launch = true ## Automatically assigns a public IP to resources launched in this subnet
  tags = {
    manteiner=var.tags_subnets.Manteiner
    env = var.tags_subnets.Environment
    public = var.tags_subnets.Public
    Name= var.tags_subnets.Name_Public_sbnet 
  }
}
resource "aws_subnet" "private_subnet_virginia" {
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.private_subnet_ip
  tags = {
    manteiner=var.tags_subnets.Manteiner
    env = var.tags_subnets.Environment
    public = !var.tags_subnets.Public
    Name= var.tags_subnets.Name_Public_sbnet 
  }
}

