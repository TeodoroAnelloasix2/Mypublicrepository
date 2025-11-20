## Crear un servicio NodePort


```javascript
Kubernetes Service types allow you to specify what kind of Service you want.

The available type values and their behaviors are:

ClusterIP
    Exposes the Service on a cluster-internal IP. Choosing this value makes the Service only reachable from within the cluster. This is the default that is used if you don't explicitly specify a type for a Service. You can expose the Service to the public internet using an Ingress or a Gateway.
NodePort
    Exposes the Service on each Node's IP at a static port (the NodePort). To make the node port available, Kubernetes sets up a cluster IP address, the same as if you had requested a Service of type: ClusterIP.
LoadBalancer
    Exposes the Service externally using an external load balancer. Kubernetes does not directly offer a load balancing component; you must provide one, or you can integrate your Kubernetes cluster with a cloud provider.
ExternalName
    Maps the Service to the contents of the externalName field (for example, to the hostname api.foo.bar.example). The mapping configures your cluster's DNS server to return a CNAME record with that external hostname value. No proxying of any kind is set up.

The type field in the Service API is designed as nested functionality - each level adds to the previous. However there is an exception to this nested design. You can define a LoadBalancer Service by disabling the load balancer NodePort allocation.

```
```shell
#Crear un deployment
kubectl create deployment  deployname    --image=myimage

kubectl create deployment apache1-deploy --image=httpd

#Crear el sericio Nodeport
kubectl expose deploy apache1-deploy --port=80 --type=NodePort

#Ver el servicio
kubectl get svc
NAME                TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
apache1-deploy      NodePort       10.105.25.106   <none>        80:31848/TCP   9s
v
#ver la ip
minikube ip
192.168.49.2

curl 192.168.49.2:31848
<html><body><h1>It works!</h1></body></html>

#Ver todos los detalles
minikube service list

┌──────────────────────┬───────────────────────────┬──────────────┬───────────────────────────┐
│      NAMESPACE       │           NAME            │ TARGET PORT  │            URL            │
├──────────────────────┼───────────────────────────┼──────────────┼───────────────────────────┤
│ default              │ apache-svc                │ 80           │ http://192.168.49.2:31537 │
│ default              │ apache1-deploy            │ 80           │ http://192.168.49.2:31848 │
│ default              │ kubernetes                │ No node port │                           │
│ default              │ pod-nginx-yml-svc         │ 80           │ http://192.168.49.2:30104 │
│ kube-system          │ kube-dns                  │ No node port │                           │
│ kube-system          │ metrics-server            │ No node port │                           │
│ kubernetes-dashboard │ dashboard-metrics-scraper │ No node port │                           │
│ kubernetes-dashboard │ kubernetes-dashboard      │ No node port │                           │
└──────────────────────┴───────────────────────────┴──────────────┴───────────────────────────┘

```