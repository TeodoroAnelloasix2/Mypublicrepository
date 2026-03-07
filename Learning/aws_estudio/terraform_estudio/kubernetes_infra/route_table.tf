resource "aws_route_table" "kb_rt" {
  vpc_id = aws_vpc.kb_vpc.id
  route {
    cidr_block = var.kb_rt_cidr
    gateway_id = aws_internet_gateway.kb_ig.id
  }
}

variable "kb_rt_cidr" {
  type = string
}

# Route table association
resource "aws_route_table_association" "kb_rt_association" {
  subnet_id      = aws_subnet.kb_pblc_sb.id
  route_table_id = aws_route_table.kb_rt.id
}