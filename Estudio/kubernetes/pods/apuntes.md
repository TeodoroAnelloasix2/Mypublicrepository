# Pods


## Crear un pods con run
```shell

kubectl run pod-name --image=image_name 
#ejemplo:

kubectl run podhttpd --image=httpd
# salida ->  pod/podhttpd created

kubectl run pod-apache --image=httpd --port=8080
```

## Obtener info de pods
```shell
kubectl get pods
#NAME       READY   STATUS    RESTARTS   AGE
#podhttpd   1/1     Running   0          2m7s

kubectl get pods -o wide
#NAME       READY   STATUS    RESTARTS   AGE     IP           NODE              NOMINATED NODE   READINESS GATES
#podhttpd   1/1     Running   0          2m43s   10.244.1.2   des-cluster-m02   <none>           <none>

kubectl logs pod-name --tail=30  #Ver logs del pod
kubectl logs -f pod-name #Ver logs en tiempo real
# Con describe
kubectl describe resourcetype/resource
#ejemplo   pod/pod-name
kubectl describe pod/podhttpd

```

## Ejecutar un comando que ataca el pods
```shell
# kubectl exec [POD] -- [COMMAND] 
#Ejemplo: 
kubectl exec podhttpd -- uname -a
Linux podhttpd 6.8.0-65-generic #68~22.04.1-Ubuntu SMP PREEMPT_DYNAMIC Tue Jul 15 18:06:34 UTC 2 x86_64 GNU/Linux

# Modo interactivo
kubectl exec pod -it -- bash
```
## Proxy del kubectl
```shell
# Arrancar app backend de kubectl que provee api 
kubectl proxy

#http://localhost:8001/api/v1/namespaces/default/pods
```

# Crear un servicio
```shell

kubectl expose pod pod-apache --port=80 --name=apache-svc --type=LoadBalancer
#salida -> service/apache-svc exposed
#crea un objeto de tipo servicio
  kubectl get svc
# NAME         TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
# apache-svc   LoadBalancer   10.100.187.49   <pending>     80:31537/TCP   69s
# kubernetes   ClusterIP      10.96.0.1       <none>        443/TCP        76m
minikube ip -p des-cluster
192.168.49.2  # Ip donde se estàn alojando los pods (cluster)
# Peticion al servicio 
curl http://192.168.49.2:31537
```
```html
<html><body><h1>It works!</h1></body></html>
```
```
[ Cliente (navegador/curl) ]
              |
              v
      +-----------------+
      |   Service       |   <--Exposición estable (ClusterIP/NodePort/LoadBalancer)
      +-----------------+
              |
     ---------------------
     |                   |
     v                   v
+-----------+      +-----------+
|   Pod 1   |      |   Pod 2   |   <-- Réplicas del mismo Deployment
| (imagen)  |      | (imagen)  |
+-----------+      +-----------+

```
