# create-sg.tf

resource "aws_security_group" "public" {

#  name = "cloudcasts-${var.infra_env}-public-sg"
  name = "public-sg"
  description = "Public internet access"
  vpc_id = aws_vpc.vpc.id

 

  tags = {
    Name        = "public-sg"
    ManagedBy   = "terraform"
  }

}

 

resource "aws_security_group_rule" "public_out" {

  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]
 
  security_group_id = aws_security_group.public.id
}

 

resource "aws_security_group_rule" "public_in_ssh" {

  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}
 

resource "aws_security_group_rule" "public_in_http" {

  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}
 

resource "aws_security_group_rule" "public_in_https" {

  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.public.id
}

