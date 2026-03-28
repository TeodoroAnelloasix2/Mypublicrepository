terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.38.0"
    }
    local = {
        source = "hashicorp/local"
        version = "~>2.6.0"
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