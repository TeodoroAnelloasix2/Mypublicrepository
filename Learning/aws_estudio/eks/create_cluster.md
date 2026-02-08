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