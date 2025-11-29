resource "aws_instance" "ec2_amazon_linux" {
  ami           = var.ec2_al_spec.Ami_code
  instance_type = var.ec2_al_spec.inst_type
  subnet_id     = aws_subnet.private_subnet_virginia.id
  tags = {
    Name     = var.ec2_al_spec.Name
    Ami_desc = var.ec2_al_spec.Ami_desc
  }
}

output "ec2_private" {
  description = "Desired outputs: "
  value = {
    arn        = aws_instance.ec2_amazon_linux.arn
    hostId     = aws_instance.ec2_amazon_linux.host_id
    private_ip = aws_instance.ec2_amazon_linux.private_ip
  }
}