variable "def_tags" {
  type = map(string)
}

variable "my_ip" {
  type = string
  default = ""
}

variable "ingress_port_list" {
  type = list(string)
}

variable "k0s_key_name" {
  type = string
  default = "k0s_key"
}