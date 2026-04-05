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

```shell
#Ver ip/puertos mapeados
kubectl describe svc nginx1-svc
Name:                     nginx1-svc
Namespace:                default
Labels:                   <none>
Annotations:              <none>
Selector:                 app=nginx-1,entorno=desarrollo
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.97.70.179
IPs:                      10.97.70.179
Port:                     <unset>  80/TCP
TargetPort:               80/TCP
NodePort:                 <unset>  30007/TCP
Endpoints:                10.244.0.3:80,10.244.1.11:80,10.244.1.12:80 #Ip de los pods
Session Affinity:         None
External Traffic Policy:  Cluster
Internal Traffic Policy:  Cluster
Events:                   <none>


kubectl get pods -o wide
NAME                             READY   STATUS    RESTARTS   AGE   IP            NODE              NOMINATED NODE   READINESS GATES
nginx-wkloads-6d98654f47-2k4qb   1/1     Running   0          30m   10.244.1.12   des-cluster-m02   <none>           <none>
nginx-wkloads-6d98654f47-nhzfs   1/1     Running   0          30m   10.244.1.11   des-cluster-m02   <none>           <none>
nginx-wkloads-6d98654f47-skssb   1/1     Running   0          30m   10.244.0.3    des-cluster       <none>           <none>

#Si escalamos las listas de ip de los pods se actualiza
kubectl scale deploy nginx-wkloads --replicas=5
kubectl describe svc nginx1-svc
Endpoints:   10.244.0.3:80,10.244.1.11:80,10.244.1.12:80 + 2 more...

#Si se elimina un pod y se crea otro nuevo y la ip ha cambiado se mapea en el service sin problema
```