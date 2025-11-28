cidr_virginia = "10.10.0.0/16"
tags_virginia = {
  Manteiner   = "italianodev"
  Environment = "development"
  Vpc_Name = "vpc1-virginia"
}

public_subnet_ip  = "10.10.0.0/24"
private_subnet_ip = "10.10.1.0/24"

tags_subnets = {
  Environment = "Development"
  Manteiner = "italianodev"
  Public = true
  Name_Private_sbnet = "private_virginia"
  Name_Public_sbnet = "public_virginia"
}