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
