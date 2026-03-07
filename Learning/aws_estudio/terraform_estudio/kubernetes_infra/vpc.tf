#vpc

resource "aws_vpc" "kb_vpc" {
  cidr_block           = var.kb_vpc_cird
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = var.kb_vpc_name
    Desc = "Learning kubernetes and minikube"
  }
}

variable "kb_vpc_cird" {
  type = string
}

variable "kb_vpc_name" {
  type = string
}