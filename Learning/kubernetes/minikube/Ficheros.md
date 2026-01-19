# 📂 Apuntes ficheros

## 📁 .kube

```shell
cat ~/.kube/config
# Muestra el contenido del archivo de configuración de kubectl
#NO es un fichero de minikube si no propio del controlador de clusters

# Este archivo contiene:
# - Información sobre los clústeres configurados
# - Usuarios y credenciales
# - Contextos (qué usuario se conecta a qué clúster)
# - El contexto actual que kubectl usará por defecto
```

## 📦 .minikube

```shell
ls ~/.minikube/machines
# Lista la información de los clústeres creados con Minikube
# (el primero por defecto suele llamarse "minikube")

cat ~/.minikube/machines/minikube/config.json
# Muestra la configuración detallada del clúster específico "minikube"
# (CPU, memoria, driver, versión de Kubernetes, etc.)
```