# 📘 Apuntes de minikube

## 🚀 start
```shell
minikube start --driver=docker 
# Inicia un clúster de Kubernetes usando Docker como driver

minikube delete && minikube start --driver=docker
# Borra el clúster actual y lo reinicia limpio con Docker

minikube start --driver=docker -p cluster2 --nodes=2 # en versiones modernas + de 1 nodo
# Crear otro cluster 

#Utilizar otro container run time (motor de contenedores )
minikube start --container-runtime=cri-o -p clusterCrio1

⚖️ Diferencia clave

--driver = cómo corre Minikube en la máquina.

--container-runtime = cómo corre Kubernetes los contenedores dentro del clúster.
```

## 📊 status
```shell
minikube status 
# Muestra el estado del clúster (host, kubelet, apiserver, kubeconfig)

```
## profile 
```shell
minikube profile list 
minikube profile list --output=json | jq
┌──────────┬────────┬─────────┬──────────────┬─────────┬────────┬───────┬────────────────┬────────────────────┐
│ PROFILE  │ DRIVER │ RUNTIME │      IP      │ VERSION │ STATUS │ NODES │ ACTIVE PROFILE │ ACTIVE KUBECONTEXT │
├──────────┼────────┼─────────┼──────────────┼─────────┼────────┼───────┼────────────────┼────────────────────┤
│ cluster2 │ docker │ docker  │ 192.168.58.2 │ v1.34.0 │ OK     │ 2     │                │ *                  │
│ minikube │ docker │ docker  │ 192.168.49.2 │ v1.34.0 │ OK     │ 1     │ *              │                    │
└──────────┴────────┴─────────┴──────────────┴─────────┴────────┴───────┴────────────────┴────────────────────┘

minikube profile list --detailed=true
minikube profile name #Cambia de contexto hacia donde atacan los comandos

#Ejemplo

minikube profile cluster-des
✅  minikube profile was successfully set to cluster-des
```

## Dashboard

```shell
minikube dashboard #Arrancar herramienta web
```

## 📝 logs

```shell
minikube logs
# Muestra los registros internos de Minikube (útil para depuración)

```

## 🌐 ip
```shell
minikube ip
# Devuelve la IP del nodo Minikube, usada para acceder a servicios expuestos
```
## delete

```shell
minikube delete -p cluster2 
#borra el cluster especificado con -p 
```