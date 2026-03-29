# K0s notes

### Start

###### To deploy infra on cloud using terraform
```sh 
https://github.com/TeodoroAnelloasix2/Mypublicrepository/tree/main/Learning/aws_estudio/terraform_estudio/k0s_infra
```

```sh
k0sctl apply --config ./k0s/k0sctl.yaml
```

### Attach the cluster  at kubectl

```sh

#Open ssh port forwarding in a separated terminal and keep connection alive
ssh -L LOCAL_PORT:TARGET_HOST:TARGET_PORT JUMP_HOST


k0sctl kubeconfig > kubeconfig
export KUBECONFIG=/path/to/kubeconfigfile

# Modify kubeconfig to use localhost
sed -i 's/https:\/\/10\.0\.2\.82:6443/https:\/\/localhost:6443/' kubeconfig

# Test connection

kubectl get nodes
NAME                        STATUS   ROLES    AGE   VERSION
ip-10-0-2-56.ec2.internal   Ready    <none>   67m   v1.21.1-k0s1
ip-10-0-2-82.ec2.internal   Ready    <none>   86m   v1.21.1-k0s1

```

# Some kubectl command

```sh
kubectl get nodes

#Output:
#NAME                        STATUS   ROLES    AGE   VERSION
#ip-10-0-2-56.ec2.internal   Ready    <none>   67m   v1.21.1-k0s1
#ip-10-0-2-82.ec2.internal   Ready    <none>   86m   v1.21.1-k0s1

kubectl describe nodes node-name
kubectl top node node-name
kubectl cluster-info

kubectl apply -f apps/app1.yaml
kubectl describe pod k0s-web1 

kubectl logs pod-name -c container_name

kubectl exec mypod -c ruby-container -- command

kubectl exec k0s-web1 -it -c front1 -- /bin/bash

kubectl port-forward --address 0.0.0.0 pod/my-pod   LOCAL_PORT:POD_TARGET_PORT
kubectl port-forward --address 0.0.0.0 pod/k0s-web1 8080:80

kubectl get namespaces 
kubectl create namespace app2


kubectl apply -f apps/app2.yaml --namespace app2
kubectl get pods --namespace app2

#Output:
#NAME       READY   STATUS    RESTARTS   AGE
#k0s-web2   1/1     Running   0          21s


kubectl config set-context --current --namespace=app2
# Output:
# Context "my-k0s-cluster" modified.

kubectl delete -f apps/http_service.yaml 
kubectl scale --replicas 5 deployment/my_deployment_name
```