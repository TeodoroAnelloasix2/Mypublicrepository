cidr_virginia = "10.10.0.0/16"
tags_virginia = {
  Manteiner   = "italianodev"
  Environment = "development"
  Vpc_Name    = "vpc1-virginia"
}

public_subnet_ip  = "10.10.2.0/24"
private_subnet_ip = "10.10.1.0/24"

tags_subnets = {
  Environment        = "Development"
  Manteiner          = "italianodev"
  Public             = true
  Name_Private_sbnet = "private_virginia"
  Name_Public_sbnet  = "public_virginia"
}

ec2_al_spec = {
  Ami_code  = "ami-0fa3fe0fa7920f68e"
  inst_type = "t3.micro"
  Name      = "ec2-private"
  Ami_desc  = "Ami of amazon linux 64bits x86, uefi preferred"
}