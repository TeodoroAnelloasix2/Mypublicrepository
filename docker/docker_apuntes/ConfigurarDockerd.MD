## CONFIGURAR DOCKERD

```
[Configuracion demonio docker](https://docs.docker.com/reference/cli/dockerd/)
```

**Archivo: daemon.json**
```
Se encuentra en /etc/docker/
Por ejemplo:

```
```json
{
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "10m",
    "max-file": "3"
  }
}
```
```shell
sudo systemctl restart docker.service 
```

```shell
#deploy2dcker.sh

dockerd \
        -H unix:///var/run/docker-desa.sock \   #Socket de control
        -p /var/run/docker-desa.pid \           #Configurar docker pid
        --iptables=false \                      #No ip tables
        --ip-masq=false \                        
        --bridge=br-41ec65ed30f7 \             #Red del demonio docker, aqui hay que asciar la red creada -> ver apartado crear red
        --data-root=/var/lib/docker-desa \     #Directorio root de trabajo del demonio
        --exec-root=/var/run/docker-desa       #Ejecutable del demonio
```
```shell
#Crear red
docker network create red2
nmcli connection #ver redes


docker network create red2
41ec65ed30f78dc4b36e30267f15675a792e6e17202eeeb02eb5056d515ac0b7
nmcli connection 
NAME              UUID                                  TYPE    DEVICE          
Casawifi         xxx-xxx-xxx  wifi    wlp2s0          
docker0          f4073270-85a1-4ab1-82dd-6b772cd1088f  bridge  docker0         
br-41ec65ed30f7  605d7bdc-c49a-42c1-8206-7d2c49676fc2  bridge  br-41ec65ed30f7 

sudo ./deploy2dcker.sh 
```
```shell
#Listar los contextos actuales
docker context ls
NAME        DESCRIPTION                               DOCKER ENDPOINT               ERROR
default *   Current DOCKER_HOST based configuration   unix:///var/run/docker.sock   

#Crear otro contextos hacia el dockerd secundario
docker context create nombre --docker host=conexion
docker context create docker-desa --docker host=unix:///var/run/docker-desa.sock  #Esto el que indicamos con el -H 
docker-desa
Successfully created context "docker-desa"

docker context use docker-desa 
docker-desa
Current context is now "docker-desa"

docker context inspect docker-desa

 docker context use default #Volver al contexto por defecto
```
