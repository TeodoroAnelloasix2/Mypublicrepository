module "vpc_virginia" {
  source             = "terraform-aws-modules/vpc/aws"
  name               = var.vpc_name_virginia
  cidr               = var.vpc_cidr_block
  azs                = var.ava_zones_virginia
  private_subnets    = var.vpc_subnet1
  public_subnets     = var.vpc_public1
  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform  = true
    Enviroment = "development"
    Region ="virginia"
  }
  providers = {
    aws = aws.virginia
  }
}

#same size/len -> azs private_subnets public_subnets


module "vpc_ohio" {
  source             = "terraform-aws-modules/vpc/aws"
  name               = var.vpc_name_ohio
  cidr               = var.vpc_cidr_block
  azs                = var.ava_zones_ohio
  private_subnets    = var.vpc_subnet1
  public_subnets     = var.vpc_public1
  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform  = true
    Enviroment = "staging"
    Region ="ohio"

  }
  providers = {
    aws = aws.ohio
  }
}