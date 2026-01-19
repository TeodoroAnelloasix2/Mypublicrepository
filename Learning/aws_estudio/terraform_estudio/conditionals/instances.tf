#Conditional example
variable "enable_monitoring" {
  type        = bool
  description = "Allow to deploy of monitoring server"
}

resource "aws_instance" "monitoring" {
  count         = var.enable_monitoring ? 1:0
# If enable_monitoring is true → count = 1 (one instance created)
# If enable_monitoring is false → count = 0 (no instance created)

  ami           = "ami-068c0051b15cdb816"
  instance_type = "t3.micro"
  tags = {
    "Name" = "Monitoring"
  }
}

variable "enable_dns" {
  type = number
  description = "Allow to deploy dns server"
}


resource "aws_instance" "dns" {
  count         = var.enable_dns==1 ? 1:0
  ami           = "ami-068c0051b15cdb816"
  instance_type = "t3.micro"
  tags = {
    "Name" = "dns"
  }
}

#Terraform console allows to try conditionals statements 
/*
terraform console
> (1 == 1) && (2 == 2)
true

> (1 == 1) || (3 == 2)
true

> (1 == 3) || (3 == 2)
false

> "h" == "h"
true

> lower("h") == upper("h")
false
*/
