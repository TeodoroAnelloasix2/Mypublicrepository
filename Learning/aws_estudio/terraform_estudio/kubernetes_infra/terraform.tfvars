# VPC variables values
kb_vpc_cird = "10.0.0.0/16"
kb_vpc_name = "vpc_kubernetes"

# Subnet variables values
kb_pblc_sb_az   = "us-east-1a"
kb_pblc_sb_cidr = "10.0.1.0/24"
kb_pblc_sb_name = "kubernetes public subnet"


# Internet gateway variables values
kb_ig_name = "kubernetes internet gateway"

# Route table variables values
kb_rt_cidr = "0.0.0.0/0"

# Key variables values
kb_key_name = "kbkey"


# Ec2 variables values
kb_srv_type = "t3.medium"
kb_srv_ami = "ami-0030e4319cbf4dbf2"
init_script = "init.sh"

# Security group variables values
ingress_port_list = [80,8080,443]

