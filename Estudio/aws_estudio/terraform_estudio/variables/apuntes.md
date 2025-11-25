# Variables with tfvars file

```
The best way to work with the variables and their values is:

```

```
Create a file called:
- terraform.tfvars
- terraform.tfvars.json
- *.auto.tfvars  (example: servers.auto.tfvars)
- *.auto.tfvars.json

There are reserved name for variables values files!
```

```
create a file with empty variables and terraform wil automatically assign the value defined in the tfvars file
```

## Hierarchy

```

1 -var | --var-file (command line)
2 terraform.tfvars 
3 *.auto.tfvars
4 environment variable (export TF_VAR_myvar)
```