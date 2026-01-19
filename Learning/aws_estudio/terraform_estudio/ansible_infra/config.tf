terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.22.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.6.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "nvirginia"
  default_tags {
    tags = var.def_tags
  }
}