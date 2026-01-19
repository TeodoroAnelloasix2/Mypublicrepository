
# Count
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
    "Name" = var.instances[count.index]
  }
}


#For each (for each loop only accepts map type or set type )
variable "servers" {
  description = "List of servers"
  type        = set(string)
  default     = ["dns", "dhcp", "dc"]
}
resource "aws_instance" "srvs" {
  for_each = var.servers
  ami      = "ami-068c0051b15cdb816"
  instance_type = "t3.micro"
  tags = {
    "Name" = each.value
  }
}

# Using for_each with list and toset function
variable "myservers" {
  description = "List of servers"
  type        = list(string)
  default     = ["dns2", "dhcp2", "dc2"]
}
resource "aws_instance" "srvs2" {
  for_each = toset(var.myservers)
  ami      = "ami-068c0051b15cdb816"
  instance_type = "t3.micro"
  tags = {
    "Name" = each.value
  }
}