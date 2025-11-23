module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  name               = var.vpc_name
  cidr               = var.vpc_cidr_block
  azs                = var.ava_zones
  private_subnets    = var.vpc_subnet1
  public_subnets     = var.vpc_public1
  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform  = true
    Enviroment = "development"
  }
}

#same size/len -> azs private_subnets public_subnets