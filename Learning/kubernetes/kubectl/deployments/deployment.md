# Deployments notes 

## How it work?
```javascript
+------------------------------------------------------+
|                     Deployment                       |
|              (desired state / strategy)              |
|                                                      |
|   +----------------------------------------------+   |
|   |                 ReplicaSet                   |   |
|   |          (ensures pod replicas)              |   |
|   |                                              |   |
|   |   +---------------+  +---------------+       |   |
|   |   |      Pod      |  |      Pod      |       |   |
|   |   |---------------|  |---------------|       |   |
|   |   |  Container    |  |  Container    |       |   |
|   |   |  (your app)   |  |  (your app)   |       |   |
|   |   +---------------+  +---------------+       |   |
|   |                                              |   |
|   |   +---------------+                          |   |
|   |   |      Pod      |                          |   |
|   |   |---------------|                          |   |
|   |   |  Container    |                          |   |
|   |   |  (your app)   |                          |   |
|   |   +---------------+                          |   |
|   +----------------------------------------------+   |
+------------------------------------------------------+
```
### Create deployment
```sh
kubectl create deployment deploy-example --image=nginx
```
### Get Deployments info
```sh
kubectl get deployments
kubectl describe deployments <deployment-name>
```

### Scale deployment

```sh
kubectl scale --replicas 3 deployment.apps/<deploy-name>
``` 
### Expose deployment

```sh
kubectl expose deployment.apps/<deploy-name> --type=<ServiceType> --port=80 --target-port=80 --name=<service-name>
```

### Delete deployment

```sh
kubectl delete deployments.apps/<deployment-name>
```

## Get info
```sh
NODE_PRIVATE_DNS=$(kubectl get pod <pod-name> -o=jsonpath='{.spec.nodeName}')
SERVICE_NODE_PORT=$(kubectl get svc <service-name> -o=jsonpath='{.spec.ports[0].nodePort}')
NODE_PUBLIC_IP=$(aws ec2 describe-instances  --region <region> --query "Reservations[0].Instances[0].PublicIpAddress" --filters "Name=private-dns-name,Values=$NODE_PRIVATE_DNS" --output text)
SECURITY_GROUP_ID=$(aws ec2 describe-instances  --region <region> --query "Reservations[].Instances[].NetworkInterfaces[].Groups[].GroupId"  --filters "Name=private-dns-name,Values=$NODE_PRIVATE_DNS" --output text)

# Allow traffic
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol "tcp" --port $SERVICE_NODE_PORT --cidr 0.0.0.0/0 --region eu-south-2
```