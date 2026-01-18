terraform {
  required_version = ">= 0.12.2"

  backend "s3" {
    region         = "us-east-1"
    bucket         = "backendmodule-dev-terraform-state"
    key            = "terraform.tfstate"
    dynamodb_table = "backendmodule-dev-terraform-state-lock"
    profile        = ""
    encrypt        = "true"
  }
}
