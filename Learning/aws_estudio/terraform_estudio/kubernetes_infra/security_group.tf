resource "aws_security_group" "kb_sg" {
  vpc_id = aws_vpc.kb_vpc.id
  dynamic "ingress" {
    for_each = var.ingress_port_list
    content {
      from_port = ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = [ var.my_ip ]
    }
  }
  egress  {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ var.my_ip ]
  }
}

resource "aws_security_group_rule" "in_ssh" {
  security_group_id = aws_security_group.kb_sg.id
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ var.my_ip ]
}
variable "ingress_port_list" {
  type = list(string)
}

variable "my_ip" {
  type = string
  default = ""
}