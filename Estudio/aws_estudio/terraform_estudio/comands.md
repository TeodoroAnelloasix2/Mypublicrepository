# Terraform commands

### terraform validate

```shell
terraform validate # Check if there are errors in our projects and display its
```

### terraform fmt
```shell
terraform fmt # This command automatically formats our project's files
```

### terraform show

```shell
terraform show # This command display our infraestructure consulting terraform.tfstate
terraform show -json
```

### terraform providers

```shell
terraform providers # This command display our providers its versions and constraints
```
### terraform outputs

```shell
terraform output # Display our defined outputs
terraform output outputname 
```

### terraform plan

```shell
terraform plan
```

### terraform refresh

```shell
terraform refresch
```

## terraform graph

```shell
terraform graph #Create a simplified graph which describes only the dependency ordering of the resources (resource and data blocks) in the configuration.

terraform graph -type=plan | dot -Tpng >graph.png  #Generate a file with graph
terraform graph -type=plan | dot -Tsvg >graph.svg 
```
## terraform state

```shell
terraform state list #The terraform state list command lists resources within a Terraform state.
#Outputs:
# aws_instance.webserver
terraform state show aws_instance.webserver #The terraform state show command shows the attributes of a single resource in the Terraform state.
teraform state rm #The terraform state rm command removes the binding to an existing remote object without first destroying it.
#The remote object continues to exist but is no longer managed by Terraform.
terraform state mv #The terraform state mv command changes bindings in Terraform state so that existing remote objects bind to new resource instances.
```
### Example terraform state mv

```javascript
-resource "packet_device" "worker" { //Before
+resource "packet_device" "helper" { //later
   ...
 }

```
```shell
terraform state mv packet_device.worker packet_device.helper
# We move the state so that the existing resource is associated with the new instance.
```

# Destroy

```shell
terraform destroy # Delete the whole infraestructure
terraform destroy --target=aws_instance.my_instance # Delete just specified target
```

# taint

### Deprecated (specify --replace instead)
```shell
# The terraform taint command marks specified objects in the Terraform state as tainted. Use the terraform taint command when objects become degraded or damaged. Terraform prompts you to replace the tainted objects in the next plan you create.

terraform list
#output:
aws_instance.webserver

terraform taint aws_instance.webserver
#Resource instance aws_instance.webserver has been marked as tainted.
terraform untaint aws_instance.webserver
#Resource instance aws_instance.webserver has been successfully untainted.

terraform plan --replace aws_instance.webserver 
```

# Import

```shell
# The terraform import command imports existing resources into Terraform.

terraform import 
terraform import aws_instance.foo i-abcd1234

# How to import manually created ec2
# Define empty resource
```
```javascript
resource "aws_instance" "myec2" {
}
```
```shell
terraform import aws_instace.myec2 i-03098cb47a04eXXXXXX

#output:
terraform import aws_instance.myec2 i-03098cb47aXXX
aws_instance.myec2: Importing from ID "i-03098cb47a04e9381"...
aws_instance.myec2: Import prepared!
  Prepared aws_instance for import
aws_instance.myec2: Refreshing state... [id=i-03098cb47a0XXXXx]

Import successful!

The resources that were imported are shown above. These resources are now in
your Terraform state and will henceforth be managed by Terraform.

# Then we can do terraform state show aws_instace.myec2 to display the resource's information. We can copy and paste usefull information into the previously defined resource block.

```

# Workspace

```shell
# To list current workspace

terraform workspace list
* default

#To create new workspace
terraform workspace new myworkspace

# To change current workspace

terraform workspace select myworkspace
```

# How to deploy into different workspace
```shell
terraform workspace new dev
terraform workspace new prod

terraform workspace select prod
```

```javascript

variable "my_cidrs"{
  type = map[string]
}

my_cidrs = {
  prod = "10.0.1.0/16"
  dev = "10.0.2.0/16"
}

resource "aws_vpc" "vpc_virginia"{
  cidr_block = lookup(var.my_cidrs,terraform.workspace,"not found")
}
```

# Console 

```shell
#The terraform console command opens an interactive console for evaluating expressions.
terraform console

# Terraform provides many useful built-in functions for data transformation and logic
```