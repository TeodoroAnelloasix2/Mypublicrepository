# aws cli 

## Install aws cli

```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" && unzip awscliv2.zip && sudo ./aws/install
```
## Config aws cli
``` 
aws configure
```

## Test identity after aws configure
```shell
aws sts get-caller-identity
aws iam list-users
```