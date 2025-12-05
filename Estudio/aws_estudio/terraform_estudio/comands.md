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

