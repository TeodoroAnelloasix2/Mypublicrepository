# Create cluster with eksctl


### To create cluster
```shell
eksctl create cluster --name=eksdemo1 \
--region=us-east-1 \
--zones=us-east-1a,us-east-1b \
--without-nodegroup
```
### To delete cluster

```shell
eksctl delete cluster --name=eksdemo1 --region=us-east-1
```


### To list clusters
```sh
eksctl get cluster
```

### To create IAM OIDC provider

```sh
# Setup IAM OIDC provider for a cluster to enable IAM roles for pods
eksctl utils associate-iam-oidc-provider   --region us-east-1 \
--cluster eksdemo1 --approve
```

### To create ec2 key-pair

```sh
# Create ec2 key-pair

aws ec2 create-key-pair \
  --key-name kube-demo \
  --key-type ed25519 \
  --query 'KeyMaterial' \
  --output text  > my_key_pair/kube-demo.pem

# Ensure the was succesfully created 

aws ec2 describe-key-pairs --key-names kube-demo --region us-east-1

```
### To create node group 

```sh
eksctl create nodegroup --cluster=eksdemo1 \
    --region=us-east-1 \
    --name=eksdemo1-ng-publuc1 \
    --node-type=t3.medium \
    --nodes=2 \
    --nodes-min=2 \
    --nodes-max=4 \
    --node-volume-size=20 \
    --ssh-access \
    --ssh-public-key=kube-demo \
    --managed \
    --asg-access \
    --external-dns-access \
    --full-ecr-access \
    --appmesh-access \
    --alb-ingress-access
```

### To get nodegroup info
```sh
eksctl get nodegroup --cluster=eksdemo1
```
### To delete nodegroup
```
eksctl delete nodegroup \
  --cluster=eksdemo1 \
  --region=us-east-1 \
  --name=eksdemo1-ng-publuc1
```


### To display context info

```sh
kubectl config view --minify
```