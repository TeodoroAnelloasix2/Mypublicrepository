variable "vpc_cidr_block" {
  description = "cidr principal block"
  type        = string
}

variable "aws_region_virgina" {
  description = "Aws default region us-east-1 virginia"
  type        = string
}
variable "aws_region_ohio" {
  type        = string
  description = "Aws region ohio us-east-2"

}
variable "vpc_name_virginia" {
  description = "vpc name"
  type        = string
}

variable "vpc_name_ohio" {
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

variable "ava_zones_virginia" {
  description = "availabilties zones N virginia"
  type        = list(string)
}

variable "ava_zones_ohio" {
  description = "availabilties zones Ohio"
  type        = list(string)
}