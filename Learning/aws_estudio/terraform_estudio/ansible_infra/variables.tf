# Defaults tags
variable "def_tags" {
  type = map(string)
}

######

# VPC

variable "vpc_cidr" {
  type = string
}
variable "vpc_name" {
  type = string
}

######

# Public subnet

variable "pblc_sbnt_cidr" {
  type = string
}
variable "pblc_subnt_az" {
  type = string
}
variable "pblc_sbnt_name" {
  type = string
}
######

# Route table

variable "rt_cidr" {
  type = string
}

######


# Internet gateway

variable "igw_name" {
  type = string
}

######

# Security group

variable "ingress_port_list" {
  type = list(string)
}

variable "my_ip" {
  type    = string # To get ip $(curl -s ifconfig.me)
  default = ""
}
######


# ssh key

variable "key_name" {
  type = string
}

######

# AMI

variable "amis_code" {
  type = map(string)
}

#####

# instances

variable "my_ec2_type" {
  type = string
}
variable "ubuntu_init_script" {
  type = string
}
variable "aws_init_script" {
  type = string
}