variable "cidr_virginia" {
  type        = string
  description = "CIDR vpc N. Virginia"
}
variable "tags_virginia" {
  type = object({
    Manteiner   = string
    Environment = string
    Vpc_Name    = string
  })
}

variable "tags_subnets" {
  type = object({
    Manteiner          = string
    Environment        = string
    Public             = bool
    Name_Public_sbnet  = string
    Name_Private_sbnet = string
  })
}

variable "public_subnet_ip" {
  type        = string
  description = "Public subnet"
}

variable "private_subnet_ip" {
  type        = string
  description = "Public subnet"
}

variable "ec2_al_spec" {
  type = object({
    Name      = string
    Ami_desc  = string
    inst_type = string
    Ami_code  = string
  })

}
