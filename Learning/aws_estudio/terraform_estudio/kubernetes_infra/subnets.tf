resource "aws_subnet" "kb_pblc_sb" {
  vpc_id                  = aws_vpc.kb_vpc.id
  map_public_ip_on_launch = true
  availability_zone       = var.kb_pblc_sb_az
  cidr_block              = var.kb_pblc_sb_cidr
  tags = {
    Name = var.kb_pblc_sb_name
  }
}


variable "kb_pblc_sb_cidr" {
  type = string
}

variable "kb_pblc_sb_az" {
  type = string
}

variable "kb_pblc_sb_name" {
  type = string
}