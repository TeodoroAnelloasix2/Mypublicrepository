resource "aws_instance" "ec2_amazon_linux" {
  ami           = var.ec2_al_spec.Ami_code
  instance_type = var.ec2_al_spec.inst_type
  subnet_id     = aws_subnet.private_subnet_virginia.id
  key_name = data.aws_key_pair.key.key_name # To use data info
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


#Data block requests that Terraform read from a given data source and export the result under the given local name. 
#The name is used to refer to this resource from elsewhere in the same Terraform module, but has no significance outside of the scope of a module.
data "aws_key_pair" "key" {
  key_name = "mykey"
}