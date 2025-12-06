def_tags = {
  Environment = "developement"
  Manteiner   = "italianodevops"
}

vpc_config = {
  cidr         = "10.0.0.0/16"
  dns_hostname = true
  dns_support  = true
  name         = "wa1vpc"
}

public_sbnt_config = {
  cidr   = "10.0.1.0/24"
  maping = true
  name   = "wa1pubsubnt"
}

config_igtw = {
  name = "wa1igtway"
}

rt_cidr = "0.0.0.0/0"

cfg_pub_out_rule = {
  Type       = "egress"
  port       = 0
  proto      = "-1"
  cidr_block = ["0.0.0.0/0"]
}

cfg_in_rules = {
  cidr_block = ["0.0.0.0/0"]
  port_http  = 80
  port_https = 443
  port_ssh   = 22
  port_app   = 8085
  proto      = "tcp"
  Type       = "ingress"
}

webappkey = {
  name      = "webappkey"
  algorithm = "ED25519"
}

ec2server = {
  name        = "webserver"
  type        = "t3.micro"
  ami_code    = "ami-0fa3fe0fa7920f68e"
  init_script = "installdocker.sh"
  ami_desc    = "Ami of amazon linux 64bits x86, uefi preferred"
}