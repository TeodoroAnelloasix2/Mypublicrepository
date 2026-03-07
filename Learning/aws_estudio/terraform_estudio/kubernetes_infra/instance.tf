resource "tls_private_key" "kb_key" {
  algorithm = "ED25519"

}

resource "aws_key_pair" "ssh_key" {
  key_name   = var.kb_key_name
  public_key = tls_private_key.kb_key.public_key_openssh
  provisioner "local-exec" {
    command = <<EOT
echo '${tls_private_key.kb_key.private_key_openssh}' > ./${var.kb_key_name}.pem 
chmod 400 ${var.kb_key_name}.pem 
EOT
  }
}


resource "aws_instance" "kb_server" {
  ami=var.kb_srv_ami
  instance_type = var.kb_srv_type
  subnet_id = aws_subnet.kb_pblc_sb.id
  key_name = aws_key_pair.ssh_key.key_name
  vpc_security_group_ids = [aws_security_group.kb_sg.id  ]
  associate_public_ip_address = true
  user_data = file(var.init_script)
  tags = {
    Name="kubernetes server"
  }
}


variable "init_script" {
  type = string
}
variable "kb_srv_type" {
  type = string
}
variable "kb_srv_ami" {
  type = string
}

variable "kb_key_name" {
  type = string
}

