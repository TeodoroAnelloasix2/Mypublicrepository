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

kubectl get pods -o [wide|yaml|json]  # -o Tipo de output, es util enviar a un fichero para leer la salida mejor 
#NAME       READY   STATUS    RESTARTS   AGE     IP           NODE              NOMINATED NODE   READINESS GATES
#podhttpd   1/1     Running   0          2m43s   10.244.1.2   des-cluster-m02   <none>           <none>

kubectl get pod/pod-nginx-yml -o yaml > pods/salidainfo/info.yaml

kubectl logs pod-name --tail=30  #Ver logs del pod
kubectl logs -f pod-name #Ver logs en tiempo real
# Con describe
kubectl describe resourcetype/resource
#ejemplo   pod/pod-name
kubectl describe pod/podhttpd

#Ver etiquetas
kubectl get pod mypod --show-labels
#Crear columnas con -L column-name
kubectl get pod tomcat-lab --show-labels -L description,entorno
NAME         READY   STATUS    RESTARTS   AGE     DESCRIPTION               ENTORNO      LABELS
tomcat-lab   1/1     Running   0          4m33s   mi-tomcat-de-desarrollo   desarrollo   description=mi-tomcat-de-desarrollo,entorno=desarrollo
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

## Crear un servicio
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
```bash
Esquema de infraestructura
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

          deployment
____________________________________     
|  +-----------+      +-----------+ |
|  |   Pod 1   |      |   Pod 2   | | <-- Réplicas del mismo Deployment
|  | (imagen)  |      | (imagen)  | |
|  +-----------+      +-----------+ |
|___________________________________|
```
## Port-forward

```shell

kubectl pot-forward pdo-name port-local:image-port
kubectl port-forward podnginx 9999:80
Forwarding from 127.0.0.1:9999 -> 80
Forwarding from [::1]:9999 -> 80   # En este caso el mapeo es contra nuestra maquina fisica 

curl http://localhost:9999
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>

```

```shell
kubectl expose
 #- crea un Service que expone los Pods de manera estable dentro o fuera del clúster

kubectl port-forward
 #- abre un túnel temporal desde tu máquina local hacia un Pod específico sin crear un Service
```

## Crear pods a partir de un manifest.yaml
```shell
kubectl create -f Nginx.yml
#Salida -> pod/pod-nginx-yml created
```
```shell
#Una vez creado el pod:
#Exponer el servicio
kubectl expose pod <podname> --name <service-name> --port=80 --type=<Service-type> 
kubectl expose pod pod-nginx-yml --name pod-nginx-yml-svc --port=80 --type=LoadBalancer #El puerto ha de ser el del expose de la imagen 
#Get info
kubectl get svc pod-nginx-yml-svc -o wide
NAME                TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE   SELECTOR
pod-nginx-yml-svc   LoadBalancer   10.110.48.223   <pending>     80:30104/TCP   32s   version=1.0.0,zone=prod

minikube ip -p des-cluster
#Salida -> 192.168.49.2
curl 192.168.49.2:30104
#Salida -> Imagen test para kubernets :)

```

## Eliminar un pod
```shell
kubectl delete pods/podhttpd
kubectl delete pod pod-name,pod-name2  #Borrar mas pods a la vez 
kubectl delete pod pod-name --grace-period=5 #Espera 5 segundos
kubectl delete pod pod-name --now #Lo borra sin esperar que terminen los procesos 
kubectl delete pod pod-name --all #Borra todo! Cuidado
```

## Comando apply

```shell
kubectl apply -f file.yaml
```

## Ver eventos de contenedor dentro de un pod

```yaml
apiVersion: "v1"
kind: Pod
metadata:
  name: "pod-multi-container" #Pod name
spec:
  containers:
  - name: web
    image: nginx
    ports:
    - containerPort: 80
  - name: "apl-monitor"  #contenedor-name
    image: alpine
    command: [ "watch", "-n5", "ping", "127.0.0.1" ]
```

```shell
kubect logs pod-name -c contenedor-name

#Ejemplo:

kubectl logs pod-multi-container -c apl-monitor
```
```shell
# Salida:
64 bytes from 127.0.0.1: seq=24524 ttl=64 time=0.050 ms
64 bytes from 127.0.0.1: seq=24525 ttl=64 time=0.051 ms
64 bytes from 127.0.0.1: seq=24526 ttl=64 time=0.096 ms
64 bytes from 127.0.0.1: seq=24527 ttl=64 time=0.069 ms
64 bytes from 127.0.0.1: seq=24528 ttl=64 time=0.082 ms
64 bytes from 127.0.0.1: seq=24529 ttl=64 time=0.114 ms
64 bytes from 127.0.0.1: seq=24530 ttl=64 time=0.057 ms
```

## Session interactiva en el pod
```shell
kubectl exec tomcat -i -t -- bash
root@tomcat:/usr/local/tomcat# 
```

## Agregar una label "etiqueta"

```shell
kubectl label pod mypod mylabel=valor

kubectl label pod tomcat-lab manteiner=italianodev
pod/tomcat-lab labeled

#Sobre escribir etiqueta existente
kubectl label --overwrite pod tomcat-lab entorno=integracion
pod/tomcat-lab labeled

kubectl get pod tomcat-lab --show-labels 
NAME         READY   STATUS    RESTARTS   AGE   LABELS
tomcat-lab   1/1     Running   0          20m   description=mi-tomcat-de-desarrollo,entorno=integracion,manteiner=italianodev

#Eliminar una etiqueta -> mylabel-
kubectl label pod tomcat-lab description-
pod/tomcat-lab unlabeled

kubectl get pod tomcat-lab --show-labels 
NAME         READY   STATUS    RESTARTS   AGE   LABELS
tomcat-lab   1/1     Running   0          29m   entorno=integracion,manteiner=italianodev
 
```

## Usar los selectors

```shell
#Se puede usar --selector o -l 
get pods --show-labels --selector entorno=desarrollo
NAME         READY   STATUS    RESTARTS      AGE    LABELS
t1           1/1     Running   0             6m3s   entorno=desarrollo,manteiner=italianodev
tomcat-lab   1/1     Running   1 (21m ago)   150m   description=mi-tomcat-de-desarrollo,entorno=desarrollo,manteiner=carlos

kubectl get pods --show-labels -l manteiner=carlos
NAME         READY   STATUS    RESTARTS      AGE    LABELS
tomcat-lab   1/1     Running   1 (24m ago)   153m   description=mi-tomcat-de-desarrollo,entorno=desarrollo,manteiner=carlos

kubectl get pods --show-labels --selector entorno=integracion,manteiner=torvall
kubectl get pods --show-labels --selector entorno!=integracion
// //                          --selector 'entorno in(desarrollo,integracion)'
#Los selectors se pueden combinar con otros comandos
kubectl delete pod  --selector 'entorno notin(desarrollo,integracion)'
#Con jsonpath
kubectl get pod tomcat-lab -o jsonpath={.metadata.annotations} | jq
```

# Deployments

```javascript
Gestiona los despliegues de nuestras aplicaciones
Al crear un deployment se lanza:

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

```shell
kubectl create deploymente mydeploy   --image=myimage 

kubectl create deployment apache-deploy --image=httpd
#deployment.apps/apache-deploy created

kubectl describe deployment mydeploy
#Info sobre replica stes
kubectl get rs  
kubectl edit 

#Salen muchas opciones! Mirar 
kubectl edit deploy mydeploy

#Escalar nuestro deploy nginx-wkloads
kubectl scale deploy nginx-wkloads --replicas=5
kubectl scale deploy -l entorno=desarrollo --replicas=6 #Apuntando a una o varias etiqueta

deployment.apps/nginx-wkloads scaled

```


# Dashboard 
```shell
#Debug de posibles problemas
kubectl get pods -n kubernetes-dashboard
kubectl logs -n kubernetes-dashboard  mykubernetes-dashboard-xxxxxxxxxx
```


## Update image

```sh
kubectl create deployment deploy-example --image=nginx:1.24.0 --replicas=2
kubectl set image deployment deploy-example nginx=nginx:1.25.0

kubectl rollout status  deployment deploy-example # to check update status
kubectl rollout history  deployment deploy-example # See update history

kubectl rollout undo deployment deploy-example                   # Perform downgrade
kubectl rollout undo deployment deploy-example  --to-revision=1  # Perform downgrade to specified revision
```


```sh
kubectl rollout history  deployment deploy-example --revision=1

deployment.apps/deploy-example with revision #1
Pod Template:
  Labels:       app=deploy-example
        pod-template-hash=56ddfcdcdc
  Containers:
   nginx:
    Image:      nginx:1.24.0
    Port:       <none>
    Host Port:  <none>
    Environment:        <none>
    Mounts:     <none>
  Volumes:      <none>
  Node-Selectors:       <none>
  Tolerations:  <none>

kubectl rollout history  deployment deploy-example --revision=2

deployment.apps/deploy-example with revision #2
Pod Template:
  Labels:       app=deploy-example
        pod-template-hash=6964cd94c4
  Containers:
   nginx:
    Image:      nginx:1.25.0
    Port:       <none>
    Host Port:  <none>
    Environment:        <none>
    Mounts:     <none>
  Volumes:      <none>
  Node-Selectors:       <none>
  Tolerations:  <none>

```