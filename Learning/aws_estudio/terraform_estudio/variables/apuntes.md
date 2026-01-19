# Variables with tfvars file

# How to define our variables
```
The best way to work with the variables and their values is:

```

```
Create a file called:
- terraform.tfvars
- terraform.tfvars.json
- *.auto.tfvars  (example: servers.auto.tfvars)
- *.auto.tfvars.json

There are reserved names for variables values files!
```

```
create a file with empty variables and terraform will automatically assign the value defined in the tfvars file
```

## Hierarchy

```

1 -var | --var-file (command line)
2 terraform.tfvars (file called with reserved name)
3 *.auto.tfvars (file called with reserved name)
4 environment variable (export TF_VAR_myvar)
```

## Variable configuration

```

https://developer.hashicorp.com/terraform/language/block/variable
```
```javascript
variable "virginia_cidr"{
    default="10.0.0.0/16"
    description = "cidr para la vpc de virginia"
    type = string
    sensitive = true
}

```
```
default, default value
description, description about the variable
type, the type of the variable
sensitive, This argument prevent terraform form showing a variable's block's value in CLI output 
```

### type
```
type = string | number | bool | any 
```

### list type
```
list type allows non-unique items
The items must all be of the same type
```
```javascript
variable "my_cidr_list" {
    description = "CIDR list for each region "
    type = list(string)
    default = ["10.0.0.0/16","10.1.0.0/16"]
}


resource "aws_vpc" "vpc_1"{
    cidr_block=var.my_cidr_list[0]
    tags = {
        Name = "vpc_virginia"
        Env = "des"
    }
}

resource "aws_vpc" "vpc_2"{
    cidr_block=var.my_cidr_list[1]
    tags = {
        Name = "vpc_ohio"
        Env = "pre"
    }
}
```
### Tuple type

```
Tuple type is very similar to list, but tuple allows different types for its items
```
```javascript
variable "ohio"{
    type = tuple([string,bool,number])
    default = ["10.10.0.0/16",true,1]
}

resource "aws_vpc" "vpc_ohio"{
    cidr_block=var.ohio[0]
    tags = {
        Index = var.ohio[2]
        Production = var.ohio[1]
    }
}
```

### map type

```javascript
variable "map_cidrs"{
    default = { 
        "c_virginia" = "10.0.0.0/16"
        "c_ohio" = "10.0.0.0/16"
    }
}

resource "aws_vpc" "vpc_1"{
    cidr_block=var.map_cidrs["c_virginia"]
    tags = {
        Name = "vpc_virginia"
        Env = "des"
    }
}

```
```
Apply some defaults tags to the whole defined resource in specific region
```
```javascript

provider "aws"{
    region="us-east-1"
    alias=" default-region"
    default_tags={
        tags=var.tags
    }
}

```

### set type

```
Set type does NOT allow non-unique items
We can't access a specific value by index.  We must use the entire set with the for_each function and each.value 
```

```javascript
variable "my_cidr_set" {
    description = "CIDR set for each region "
    type = set(string)
    default = ["10.0.0.0/16","10.1.0.0/16"]
}

resource "aws_vpc" "vpc"{
    for_each = var.my_cidr_set
    cidr_block = each.value
}
```

### Object type 

```
Object type is very similar to the map type,  but object type allows different types for its items
```
```javascript
variable "virginia"{
    type = object({
        name = string
        cidr = list(string)
        available = bool 
        env = string
        manteiner = string
    })
    default = {
        name = "n_virginia"
        cidr=["10.0.0.0/16"]
        available=true
        env="des"
        manteiner="itadev"
    }
}

resource "aws_vpc" "vpc_virginia"{
    cidr_block = var.virginia.cidr[0]
    tags = {
        Name = var.virginia.name
        Env= var.virginia.env
    }    
}
```


# Output

```
https://developer.hashicorp.com/terraform/language/block/output
```

```
The output block exposes information about your infrastructure that you can reference on the command line, in HCP Terraform, and in other Terraform configurations that can access your configuration's state. The output block serves four main purposes in Terraform:

Child modules can expose resource attributes to parent modules.
Root modules can display values in CLI output.
Other Terraform configurations using remote state can access root module outputs with the terraform_remote_state data source.
Passing information from a Terraform operation to an automation tool.
```

```javascript
output "linux_public_ip"{
    value = aws.instance.linux.public_ip
    description = "value= resource_type.myname.attributes_reference" 
}
```
```
To know attributes reference we can ckeck official document
```
```shell
# To invoke cli output 
terraform output

terraform output linux_public_ip
```