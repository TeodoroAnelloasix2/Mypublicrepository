#Create security group
resource "aws_security_group" "wa1_sg" {
  vpc_id = aws_vpc.wa1_vpc.id
  description = "Security group for web server instance"

  # Dynamic block
  dynamic "ingress" {
    for_each = var.ingress_port_list
    content {
      from_port =  ingress.value
      to_port = ingress.value
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}


#Allow ssh from my ip
resource "aws_security_group_rule" "in_ssh" {
  security_group_id = aws_security_group.wa1_sg.id
  type              = var.cfg_in_rules.Type
  from_port         = var.cfg_in_rules.port_ssh
  to_port           = var.cfg_in_rules.port_ssh
  protocol          = var.cfg_in_rules.proto
  cidr_blocks       = [var.my_ip]
}
