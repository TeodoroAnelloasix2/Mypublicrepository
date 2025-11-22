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
```hcl
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