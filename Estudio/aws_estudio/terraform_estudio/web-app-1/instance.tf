#Create a key.pem
resource "tls_private_key" "mykey" {
  algorithm = var.webappkey.algorithm
}
resource "aws_key_pair" "webappkey" {
  key_name   = var.webappkey.name
  public_key = tls_private_key.mykey.public_key_openssh
  provisioner "local-exec" {
    command = "echo '${tls_private_key.mykey.private_key_openssh}' > ./${var.webappkey.name}.pem"
  }
}

#Create ec2 instance

resource "aws_instance" "webserver" {
  ami                         = var.ec2server.ami_code
  instance_type               = var.ec2server.type
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.wa1_sg.id]
  subnet_id                   = aws_subnet.wa1_public_sbnt.id
  key_name                    = var.webappkey.name
  user_data                   = file(var.ec2server.init_script)
  tags = {
    Name = var.ec2server.name
  }
}