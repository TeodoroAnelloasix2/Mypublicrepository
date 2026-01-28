# Default tags
def_tags = {
  Manteiner   = "italianodevops"
  Environment = "development"
  Goal        = "Ansible lab"
}

# vpc
vpc_cidr = "10.0.0.0/16"
vpc_name = "lab_ansible_vpc"

#####

# Public sbnt

pblc_sbnt_cidr = "10.0.1.0/24"
pblc_subnt_az  = "us-east-1a"
pblc_sbnt_name = "lab_ansible_subnet"
#####

# Internet gateway

igw_name = "lab_ansible_igw"

# Route table

rt_cidr = "0.0.0.0/0"

# Security group

ingress_port_list = [80]

# ssh key
key_name = "ansible_key"

# amis
amis_code = {
  aws_linux = "ami-07ff62358b87c7116"
  redhat    = "ami-0a64f837ea2469df6"
  ubuntu    = "ami-0c398cb65a93047f2"
}

# inits_scripts

scripts = {
  "ubuntu"    = "ubuntu_init.sh"
  "aws_linux" = "aws_init.sh"
}
# instances

my_ec2_type = "t3.micro"

ubuntu_init_script = "ubuntu_init.sh"
aws_init_script    = "aws_init.sh"