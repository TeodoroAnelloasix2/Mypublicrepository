terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.22.1"
    }
  }
}

provider "aws" {
  # Configuration options
   region = var.aws_region
}

#To create our variables or trough command line terraform apply -var="aws_region=eu-west-1"
variable "aws_region" {
  description = "Aws region"
  type = string
  default = "us-east-1"
}