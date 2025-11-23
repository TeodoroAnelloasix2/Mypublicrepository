variable "vpc_cidr_block" {
  description = "cidr principal block"
  type        = string
}

variable "aws_region" {
  description = "Aws default region"
  type        = string
}

variable "vpc_name" {
  description = "vpc name"
  type        = string
}

variable "vpc_subnet1" {
  description = "first private subnet"
  type        = list(string)
}
variable "vpc_public1" {
  description = "first public network"
  type        = list(string)
}
variable "enviroment" {
  description = "Enviroment tag value"
  type        = string
}

variable "ava_zones" {
  description = "availabilties zones"
  type        = list(string)
}