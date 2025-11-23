
#| **Required Version** | **Meaning**                                                | **Considerations**                                              |
#| -------------------- | ---------------------------------------------------------- | --------------------------------------------------------------- |
#| `0.15.0`             | Only Terraform **v0.15.0 exactly**                         | To upgrade Terraform, first edit the `required_version` setting |
#| `>= 0.15`            | Any Terraform **v0.15.0 or greater**                       | Includes Terraform **v1.0.0 and above**                         |
#| `~> 0.15.0`          | Any Terraform **v0.15.x**, but **not v1.0 or later**       | Minor version updates are intended to be non-disruptive         |
#| `>= 0.15, < 2.0.0`   | Terraform **v0.15.0 or greater**, but **less than v2.0.0** | Avoids major version updates                                    |
# ¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯¯

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>6.22.1"
    }
  }
  required_version = "~>1.13.0" #This refers to terraform
}
provider "aws" {
  region = var.aws_region
}

