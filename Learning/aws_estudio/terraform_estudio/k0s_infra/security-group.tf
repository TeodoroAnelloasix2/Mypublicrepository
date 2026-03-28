resource "aws_security_group" "pblc_sg_k0s" {
  vpc_id=aws_vpc.vpc_k0s.id
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }
}

resource "aws_security_group_rule" "pblic_in_ssh_1" {
  security_group_id = aws_security_group.pblc_sg_k0s.id
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [ var.my_ip,aws_vpc.vpc_k0s.cidr_block ]
}
resource "aws_security_group" "prvt_sg_k0s" {
  vpc_id = aws_vpc.vpc_k0s.id
  
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    ipv6_cidr_blocks = [ "::/0" ]
  }
}

resource "aws_security_group_rule" "prvt_in_traffic" {
  security_group_id = aws_security_group.prvt_sg_k0s.id
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ aws_vpc.vpc_k0s.cidr_block ]
}

