#Create security group
resource "aws_security_group" "wa1_sg" {
  vpc_id = aws_vpc.wa1_vpc.id
}
#Security groups rules
#Outcoming Response 
resource "aws_security_group_rule" "public_out_rule" {
  security_group_id = aws_security_group.wa1_sg.id
  type              = var.cfg_pub_out_rule.Type
  from_port         = var.cfg_pub_out_rule.port
  to_port           = var.cfg_pub_out_rule.port
  protocol          = var.cfg_pub_out_rule.proto
  cidr_blocks       = var.cfg_pub_out_rule.cidr_block
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

# Allow http incoming traffic
resource "aws_security_group_rule" "in_http" {
  security_group_id = aws_security_group.wa1_sg.id
  type              = var.cfg_in_rules.Type
  protocol          = var.cfg_in_rules.proto
  from_port         = var.cfg_in_rules.port_http
  to_port           = var.cfg_in_rules.port_http
  cidr_blocks       = var.cfg_in_rules.cidr_block
}
#Allow https incoming traffic
resource "aws_security_group_rule" "in_https" {
  security_group_id = aws_security_group.wa1_sg.id
  type              = var.cfg_in_rules.Type
  protocol          = var.cfg_in_rules.proto
  from_port         = var.cfg_in_rules.port_https
  to_port           = var.cfg_in_rules.port_https
  cidr_blocks       = var.cfg_in_rules.cidr_block
}


# Allow http incoming traffic trough 8085
resource "aws_security_group_rule" "in_webapp" {
  security_group_id = aws_security_group.wa1_sg.id
  type              = var.cfg_in_rules.Type
  protocol          = var.cfg_in_rules.proto
  from_port         = var.cfg_in_rules.port_app
  to_port           = var.cfg_in_rules.port_app
  cidr_blocks       = var.cfg_in_rules.cidr_block
}