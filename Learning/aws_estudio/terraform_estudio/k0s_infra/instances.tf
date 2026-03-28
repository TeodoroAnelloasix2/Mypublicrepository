#ssh key

resource "tls_private_key" "k0s_generate_key" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "k0s_key" {
  key_name = var.k0s_key_name
  public_key = tls_private_key.k0s_generate_key.public_key_openssh
  provisioner "local-exec" {
    command = "echo '${tls_private_key.k0s_generate_key.private_key_openssh}' > ./${var.k0s_key_name}.pem && chmod 400 ./${var.k0s_key_name}.pem"
  }
}

#t3a.small
#aws_linux = "ami-07ff62358b87c7116"

resource "aws_instance" "bastion_server" {
  ami = "ami-07ff62358b87c7116"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.pbl_subnet.id
  key_name = aws_key_pair.k0s_key.key_name
  vpc_security_group_ids = [ aws_security_group.pblc_sg_k0s.id ]
  associate_public_ip_address = true
  user_data = file("init.sh")
  tags = {
    Name = "bastion_host_k0s"
  }
}

# Slaves
resource "aws_instance" "slave1" {
  ami = "ami-07ff62358b87c7116"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.prvt_subnet.id
  key_name = aws_key_pair.k0s_key.key_name
  vpc_security_group_ids = [ aws_security_group.prvt_sg_k0s.id ]
  associate_public_ip_address = false
   user_data = file("init.sh")
  tags = {
    Name = "slave1"
  }
}

resource "aws_instance" "slave2" {
  ami = "ami-07ff62358b87c7116"
  instance_type = "t3.micro"
  subnet_id = aws_subnet.prvt_subnet.id
  key_name = aws_key_pair.k0s_key.key_name
  vpc_security_group_ids = [ aws_security_group.prvt_sg_k0s.id ]
  associate_public_ip_address = false
   user_data = file("init.sh")
  tags = {
    Name = "slave2"
  }
}