variable "instances" {
  description = "List of my servers"
  type        = list(string)
  default     = ["apache", "msql", "jumpserver"]
}
resource "aws_instance" "internal" {
  count         = length(var.instances)
  ami           = "ami-068c0051b15cdb816"
  instance_type = "t3.micro"
  tags = {
    "Name" = "${var.instances[count.index]}-${local.sufix}"
  }
}

# Creating sufix using local values to use resulting name multiple times
locals {
  sufix="${upper(var.tags.project)}-${upper(var.tags.env)}"
}

variable "tags" {
  type = map(string)
}