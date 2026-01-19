# create-instance.tf
 
# resource "aws_key_pair" "keypair" {
#    #key_name    = "TerraformAnsible-Keypair"
#    key_name    = var.key_pair
#    #public_key  = "joc-key-pair.pub"
#    public_key  = "${file("joc-key-pair.pub")}"
#}

resource "tls_private_key" "demo_key" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "demo_key" {
  key_name   = var.key_pair_name
  public_key = tls_private_key.demo_key.public_key_openssh
  
  provisioner "local-exec"{
    command = "echo '${tls_private_key.demo_key.private_key_openssh}' > ./${var.key_pair_name}.pem"
  }
}

resource "aws_instance" "instance" {
  ami                         = var.instance_ami
#  availability_zone           = "${var.aws_region}${var.aws_region_az}"
  instance_type               = var.instance_type
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.public.id]
  subnet_id                   = aws_subnet.subnet.id
  #key_name                    = var.key_pair
  key_name                    = aws_key_pair.demo_key.key_name
  user_data                   = "${file(var.install_script_name)}"
 
#  root_block_device {
#    delete_on_termination = true
#    encrypted             = false
#    volume_size           = var.root_device_size
#    volume_type           = var.root_device_type
#  }
 
  tags = {
    "Owner"               = var.owner
    "Name"                = "${var.owner}-instance"
    "KeepInstanceRunning" = "false"
  }
}
