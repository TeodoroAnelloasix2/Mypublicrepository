resource "aws_security_group" "tf_sg" {
  vpc_id = aws_vpc.vpc_virginia.id

}

#Out
resource "aws_security_group_rule" "out_rule" {
  security_group_id = aws_security_group.tf_sg.id
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = [ "0.0.0.0/0" ]
}

# In
resource "aws_security_group_rule" "in_rule" {
  security_group_id = aws_security_group.tf_sg.id
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = [var.my_ip]
}

#Internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc_virginia.id
}

#route table
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc_virginia.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}
#Asociar route table y red publica
resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.public_subnet_virginia.id
  route_table_id = aws_route_table.public_rt.id
}