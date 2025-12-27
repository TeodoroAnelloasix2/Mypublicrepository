resource "aws_s3_bucket" "mys3" {
  bucket = "italianodevops-${local.s3sufix}"
}

resource "random_string" "s3_sufix" {
  length = 8
  special = false
  numeric = false
  upper = false # s3 bucket name must be lower case
}

locals {
  s3sufix="${var.tags.env}-${random_string.s3_sufix.result}"
}
