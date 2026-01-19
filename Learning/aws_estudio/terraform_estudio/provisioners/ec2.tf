resource "aws_instance" "ec2_amazon_linux" {
  ami           = var.ec2_al_spec.Ami_code
  instance_type = var.ec2_al_spec.inst_type
  subnet_id     = aws_subnet.public_subnet_virginia.id
  key_name      = data.aws_key_pair.key.key_name # To use data info
  associate_public_ip_address = true
  availability_zone = "us-east-1a"
  #Provisioners local-exec |remote-exec
  #Local-exec: Executing commando in the local host 
  provisioner "local-exec" {
    command = "echo Public IP ${aws_instance.ec2_amazon_linux.public_ip} >> datos_ec2"
  }
  # To test it "terraform destroy --target aws_instance.ec2_amazon_linux"
  provisioner "local-exec" {
    when    = destroy
    command = "echo Instance: ${self.public_ip} succesfully destroyed >> datos_ec2"
  }
  # Remote commando exec, we have to ensure that the ssh connection works correctly
  # Use user_data function instead
  provisioner "remote-exec" {
    inline = [
      "echo 'hola mundo > ~/saludos'"
    ]
    connection {
      type        = "ssh"
      host        = self.public_ip
      user        = "ec2-user"
      private_key = file("${var.dir_keys}mykey.pem")
      agent = false

    }
  }
  tags = {
    Name     = var.ec2_al_spec.Name
    Ami_desc = var.ec2_al_spec.Ami_desc
  }
}

data "aws_key_pair" "key" {
  key_name = "mykey"
}

output "ec2_private" {
  description = "Desired outputs: "
  value = {
    arn        = aws_instance.ec2_amazon_linux.arn
    hostId     = aws_instance.ec2_amazon_linux.host_id
    private_ip = aws_instance.ec2_amazon_linux.private_ip
    public_ip  = aws_instance.ec2_amazon_linux.public_ip
    key= aws_instance.ec2_amazon_linux.aws_key_pair
  }
}


