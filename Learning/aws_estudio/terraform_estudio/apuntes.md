# Terraform


# Instalar terrafom
```shell
wget -O - https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```


```terraform

HCL -> hashicorp configuration lenguages

```

## Creating .tf file 
```javascript
resource "local_file" "foo" {
  content  = "foo!"
  filename = "${path.module}/foo.bar"
}
```
## Firsts step:

```shell
terraform init

terraform plan
```

## Apply the desired infraestructure
```shell
terraform apply # Ask for confirmation before applying
terraform apply -auto-approve # Apply automatically without confirmation
```

## Discover created resources

```shell
terraform show
```

## Save and apply specific plan
```shell
terraform plan --out my-plan
terraform apply my-plan
```

## To automatically indent .tf files
```
terraform fmt file.tf
```

## To validate our .ts files
```shell
terraform validate
Success! The configuration is valid.

#If there are errors, this command will display them
```


# Variables

### 1 environmet variables

```shell
#We can define environmet variables that terraform can use 
#We must define them like "TF_VAR_myvar" TF_VAR is a reserved prefix and then our variables name 
export TF_VAR_vpc_name="my-vpc"
```
```javascript
variables "vpc_name"{
  description="my vpc name"
  type=string
}

```

### 2 Define variables with default value
```
default="value"
```
```javascript
variables "vpc_name"{
  description="my vpc name"
  type=string
  default="my-vpc"
}
```
```
para usar: var.vpc_name 
```
### 3 During terraform plan or terrafom apply time

```javascript
variable "myvar"{
  description="empty value variable"
}
```
```
If there are  variables without a value terraform will detect it and it will ask for their value after we execute:
teraform plan
terraform apply
```

### 4  Variables like parameters during terraform plan or terraform apply

```shell
terraform plan -var myvar="value"
```

# Dependencies
```
Terraform allows you to specify the order of resources creation using the "depends_on" clause
```

```javascript
resource "aws_subnet" "public_subnet_virginia" {
  vpc_id                  = aws_vpc.vpc_virginia.id
  cidr_block              = var.public_subnet_ip
  tags = {
    Name      = var.tags_subnets.Name_Public_sbnet
  }
}
resource "aws_subnet" "private_subnet_virginia" {
  vpc_id     = aws_vpc.vpc_virginia.id
  cidr_block = var.private_subnet_ip
  tags = {
    Name      = var.tags_subnets.Name_Private_sbnet
  }

  depends_on=[
    aws_subnet.pulic_subnet_virginia
  ]
}

```
# Target resources

```shell
terraform apply --target resource.logic_name
terraform apply --target aws_subnet.public_subnet
```

# Diagram page

```
draw.io 
```

# lifecycle
```
Lifecycle arguments help control the flow of your Terraform operations by creating custom rules for resource creation and destruction. Instead of Terraform managing operations in the built-in dependency graph, lifecycle arguments help minimize potential downtime based on your resource needs as well as protect specific resources from changing or impacting infrastructure.

```
```javascript
// Create our web server
resource "aws_instance" "example" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.sg_web.id]
  user_data              = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              sed -i -e 's/80/8080/' /etc/apache2/ports.conf
              echo "Hello World" > /var/www/html/index.html
              systemctl restart apache2
              EOF
  tags = {
    Name          = "terraform-learn-state-ec2"
    drift_example = "v1"
  }
// Implements lifecycle
lifecycle {
  prevent_destroy = true 
 }
}

//lyfecycle arguments
ignore_changes        = [tags,ami] //Ignore changes in the specified resources attributes
create_before_destroy = true //Change terraform's default behavior: , first create the new resource, then destroy the old one (normally the opposite)
replace_triggered_by=[aws_subnet.private_subnet,aws_subnet.private_subnet.id] // Changes in the specified resource will trigger a replacement of this resource
```

# Data
```
Data block requests that Terraform read from a given data source and export the result under the given local name. 
The name is used to refer to this resource from elsewhere in the same Terraform module, but has no significance outside of the scope of a module.
```
```javascript
data "aws_key_pair" "key" {
  key_name = "mykey"
}
```
```javascript
resource "aws_instance" "ec2_amazon_linux" {
  ami           = "xxxxxxxxxxxxx"
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public_subnet_virginia.id
  key_name = data.aws_key_pair.key.key_name // To use data info
}

```

# Enable Terraform logs

``` shell
Debug levels

Info       
Warning
Error
Debug
Trace      higest verbosity

# How to enable logs
# set debug level
export TF_LOG=TRACE
# set logs file
export TF_LOG_PATH=terraformlogs.txt
```