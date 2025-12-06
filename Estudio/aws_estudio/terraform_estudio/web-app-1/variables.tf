variable "def_tags" {
  type = object({
    Manteiner   = string
    Environment = string

  })
}


variable "vpc_config" {
  type = object({
    cidr         = string
    dns_support  = bool
    dns_hostname = bool
    name         = string
  })
}

variable "public_sbnt_config" {
  type = object({
    cidr   = string
    maping = bool
    name   = string
  })
}

variable "config_igtw" {
  type = object({
    name = string
  })
}

variable "rt_cidr" {
  type = string
}

variable "my_ip" {
  type    = string # To get my ip $(curl -s ifconfig.me)
  default = ""
}

variable "cfg_pub_out_rule" {
  type = object({
    Type       = string
    port       = number
    proto      = string
    cidr_block = list(string)
  })
}

variable "cfg_in_rules" {
  type = object({
    Type       = string
    port_http  = number
    port_https = number
    port_ssh   = number
    port_app   = number
    proto      = string
    cidr_block = list(string)
  })
}

variable "webappkey" {
  type = object({
    name      = string
    algorithm = string
  })
}

variable "ec2server" {
  type = object({
    name        = string
    ami_code    = string
    type        = string
    ami_desc    = string
    init_script = string
  })

}