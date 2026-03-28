
# Public acl

resource "aws_network_acl" "public_acl" {
  vpc_id = aws_vpc.vpc_k0s.id
  tags= {
    Name = "public-acl"
  }
}

resource "aws_network_acl_rule" "pblc_inbound_1" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number = 90
  egress = false
  protocol = "-1"
  rule_action = "allow"
  cidr_block = aws_vpc.vpc_k0s.cidr_block
  from_port = 0
  to_port = 0
}


resource "aws_network_acl_rule" "pblc_inbound_2" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number = 100
  egress = false
  protocol = "-1"
  rule_action = "allow"
  cidr_block = var.my_ip
  from_port = 0
  to_port = 0
}

resource "aws_network_acl_rule" "pblc_inbound_3" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number = 110
  egress = false
  protocol = "-1"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  from_port = 1024
  to_port = 65535
}


resource "aws_network_acl_rule" "pblc_outbound" {
  network_acl_id = aws_network_acl.public_acl.id
  rule_number = 100
  egress = true
  protocol = "-1"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  from_port = 0
  to_port = 0

}

resource "aws_network_acl_association" "public_acl_association" {
  subnet_id = aws_subnet.pbl_subnet.id
  network_acl_id = aws_network_acl.public_acl.id
}


# Private acl

resource "aws_network_acl" "private_acl" {
  vpc_id = aws_vpc.vpc_k0s.id
  tags = {
    Name = "private-acl"
  }
}

resource "aws_network_acl_rule" "prvt_inbound_1" {
  network_acl_id = aws_network_acl.private_acl.id
  rule_number = 100
  egress = false
  protocol = "-1"
  rule_action = "allow"
  cidr_block = var.my_ip
  from_port = 0
  to_port = 0
}

resource "aws_network_acl_rule" "prvt_inbound_2" {
  network_acl_id = aws_network_acl.private_acl.id
  rule_number = 90
  egress = false
  protocol = "-1"
  rule_action = "allow"
  cidr_block = aws_vpc.vpc_k0s.cidr_block
  from_port = 0
  to_port = 0
}

resource "aws_network_acl_rule" "prvt_inbound_3" {
 network_acl_id = aws_network_acl.private_acl.id
 rule_number = 110
 egress = false
 protocol = "-1"
 rule_action = "allow"
 cidr_block = "0.0.0.0/0"
 from_port = 1024
 to_port = 65535
}

resource "aws_network_acl_rule" "prvt_outbound" {
  network_acl_id = aws_network_acl.private_acl.id
  rule_number = 100
  egress = true
  protocol = "-1"
  rule_action = "allow"
  cidr_block = "0.0.0.0/0"
  from_port = 0
  to_port = 0

}

resource "aws_network_acl_association" "prvt_acl_association" {
  subnet_id = aws_subnet.prvt_subnet.id
  network_acl_id = aws_network_acl.private_acl.id
}