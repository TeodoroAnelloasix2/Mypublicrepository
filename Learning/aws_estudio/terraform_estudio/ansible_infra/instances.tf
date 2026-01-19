###### 
# To create ssh key

resource "tls_private_key" "ansi_key" {
  algorithm = "ED25519"
}
resource "aws_key_pair" "ssh_key" {
  key_name   = var.key_name
  public_key = tls_private_key.ansi_key.public_key_openssh
  provisioner "local-exec" {
    command = "echo '${tls_private_key.ansi_key.private_key_openssh}' > ./${var.key_name}.pem && chmod 400 ${var.key_name}.pem "
  }
}

######
variable "servers" {
  description = "List of servers ubuntu"
  type        = map(string)
  default = {
    ubuntu_slave1 = "ubuntu"
    ubuntu_slave2 = "ubuntu"
    aws_slave3    = "aws_linux"
    aws_slave4    = "aws_linux"
  }
}

resource "aws_instance" "servers" {
  for_each                    = var.servers
  ami                         = var.amis_code[each.value]
  instance_type               = var.my_ec2_type
  subnet_id                   = aws_subnet.pblc_subnet.id
  key_name                    = var.key_name
  vpc_security_group_ids      = [aws_security_group.sg_ansible.id]
  associate_public_ip_address = true
  user_data                   = strcontains(each.value, "aws") ? file(var.aws_init_script) : file(var.ubuntu_init_script)
  tags = {
    Name = "${each.key}-${random_string.ec2_sfx[each.key].result}"
  }
}

resource "random_string" "ec2_sfx" {
  for_each = var.servers
  length   = 4
  special  = false
  numeric  = true
  upper    = false
}