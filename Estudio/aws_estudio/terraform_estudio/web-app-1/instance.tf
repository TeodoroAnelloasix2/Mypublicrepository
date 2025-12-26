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


# To test import
resource "aws_instance" "myec2" {
    ami                                  = "ami-068c0051b15cdb816"
    
    associate_public_ip_address          = true
    availability_zone                    = "us-east-1a"
    
    instance_type                        = "t3.micro"
    key_name                             = "mykey"
    region                               = "us-east-1"
    subnet_id                            = "subnet-04b57ca81558a1004"
    tags                                 = {
        "Name" = "myec2"
        "Imported"="true"
    }
    vpc_security_group_ids               = [
        "sg-0e985a1ab4276b807",
     ]
}