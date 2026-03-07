resource "aws_internet_gateway" "kb_ig" {
  vpc_id = aws_vpc.kb_vpc.id
  tags = {
    Name = var.kb_ig_name
  }
}

variable "kb_ig_name" {
  type = string
}