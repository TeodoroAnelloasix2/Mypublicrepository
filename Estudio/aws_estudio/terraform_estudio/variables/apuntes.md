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
```json
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
```json
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
```json
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

```json
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

### set type

```
Set type does NOT allow non-unique items
We can't access a specific value by index.  We must use the entire set with the for_each function and each.value 
```

```json
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
```json
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