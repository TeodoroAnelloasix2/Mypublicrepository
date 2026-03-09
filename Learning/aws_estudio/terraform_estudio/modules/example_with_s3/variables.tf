locals {
  region      = "us-east-1"
  environment = "testing"
  creator     = "italianodevops"
  tags = {
    Environment = local.environment
    Creator     = local.creator
  }
}