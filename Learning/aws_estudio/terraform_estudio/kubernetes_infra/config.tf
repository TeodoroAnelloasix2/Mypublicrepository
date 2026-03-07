terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.22.1"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.6.1"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  alias  = "n_virg"
}