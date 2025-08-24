# Commandos básico y utiles para el curso



## Network tools

### Linux 
1. Install this tool to management network options
```shell
sudo apt install net-tools 
sudo apt-get install telnet
```
* Check ports listening
```shell
netstat -n --all --tcp
```
* Find specific port 
```shell
sudo lsof -i -P -n | grep 9000
```
* Testing socket whit telnet, teh format telnet ipaddress port
```shell
telnet localhost 5433
```

 ### Windows Power shell 

* Check ports listening
```powershell
Get-NetTCPConnection
```
* Obtener todas las conexiones TCP
```powershell
$connections = Get-NetTCPConnection
```
* Filtrar conexiones en estado 'Listen' o 'Established'*
```powershell
$filteredConnections = $connections | Where-Object {($_.State -eq 'Listen') -or ($_.State -eq 'Established')}
```
* Obtener información detallada de cada conexión*
```powershell
$connectionDetails = $filteredConnections | ForEach-Object {
    $localPort = $_.LocalPort
    $remotePort = $_.RemotePort
    $state = $_.State
    $processId = $_.OwningProcess
    $process = Get-Process -Id $processId
    $processName = $process.ProcessName

    [PSCustomObject]@{
        LocalPort = $localPort
        RemotePort = $remotePort
        State = $state
        Application = $processName
    }
}
```
* Mostrar la información en la consola
```powershell
$connectionDetails
```
* Find specific port 
```powershell
Get-NetTCPConnection | Where-Object {$_.LocalPort -eq 9000}
```
* Testing socket whit telnet, teh format telnet ipaddress port
```powershell
Test-NetConnection -ComputerName localhost -Port 5433
```

## **Docker**
### Trabajando con imágenes del container registry

- **Descargar una imagen desde Docker Hub:**
```shell 
docker pull nombre_de_la_imagen:tag 

docker run -d -p 80:80 docker/getting-started (-p puerto_anfitrion:puerto_contenedor)
```
- **Listar imágenes locales:**
```shell 
docker image ls
docker images 
```
- **Crear y ejecutar un contenedor a partir de una imagen:**
```shell 
#docker run [opciones] nombre_del_contenedor nombre_de_la_imagen
docker run -p 80:80 -p 7080:7080 --name containerBilling sotobotero/billingapp

```
- **crear un contenedor de postgres y una base de datos en el mismo comando:**
```shell
docker run --ulimit memlock=-1:-1 -d --name postgres -e POSTGRES_USER=sa -e POSTGRES_PASSWORD=admin -e POSTGRES_DB=product_db -p 5432:5432 postgres:13.3
```
- **Listar contenedores en ejecución:**
```shell 
docker ps
docker ps --help (para ver opciones del comado ps)
```
- **Listar todos los contenedores (incluso los detenidos):**
```shell 
docker ps -a
```
- **Detener todos los contenedores:**
```shell 
docker stop $(docker ps -q)
```
- **Iniciar todos los contenedores:**
```shell 
docker start $(docker ps -a -q)
```
- **Eliminar todos los contenedores:**
```shell 
docker rm $(docker ps -a -q)
```
### Construyendo Imágenes

- **Construir una imagen desde un Dockerfile:**
 ```shell
          -t nombre_imagen         --build-arg  argumento=valor ruta_donde_busccar (contexxto) 
  #docker build -t nombre_de_la_imagen [opciones y parametros] .
 docker build -t billingapp --no-cache --build-arg JAR_FILE=target/*.jar .
```
- **Construir una imagen con un contexto específico:**
 ```shell
  docker build -t nombre_de_la_imagen -f ruta/Dockerfile .
```
### Comandos Avanzados para Imágenes

- **Etiquetar una imagen:**
 ```shell
 docker tag nombre_de_la_imagen nueva_etiqueta

# Ejemplo, si tengo una imagen que quiero renombrar para subir a docker hub
 docker tag miapacheimage1:latest usuario/apache1:1.0.0
```
- **Loguears en un registry:**
 ```shell
docker login # te pedirá usuario y contraseña
 ```
- **Subir una imagen a Docker Hub:**
 ```shell
  docker push nombre_de_la_imagen
```
- **Descargar una imagen con una etiqueta específica:**
 ```shell
  docker pull nombre_de_la_imagen:etiqueta
```
- **Desloguearse de un registry:**
 ```shell
docker logout
 ```
### Comandos para la Gestión Básica de Contenedores

- **Detener un contenedor en ejecución:**
```shell 
docker stop nombre_del_contenedor
```

- **Iniciar un contenedor detenido:**
```shell 
docker start nombre_del_contenedor
```
- **Eliminar un contenedor:**
```shell 
docker rm nombre_del_contenedor
```
- **Eliminar una imagen local:**
```shell
docker image rm nombre_de_la_imagen

docker rmi nombre_de_la_imagen
```


### Trabajando con Redes y Volúmenes

- **Crear una red personalizada:**
 ```shell 
 docker network create nombre_de_la_red
 docker network create --subnet=192.168.10.0/24 red2  
 nmcli connection 
 docker run -it --name ubuntuServ1 --network red1 ubuntu #crear contenedor en una red 
 docker network connect red2 ubuntuServ1  #Agregar contenedor a una red
 docker network disconnect red2 ubuntuServ1 #Sacar contenedor de una red
 docker network create --subnet=172.128.0.0/16 --gateway=172.128.0.1 --ip-range=172.128.10.0/24 red3 
```
- **Listar redes:**
 ```shell
 docker network ls
```

- **Crear un volumen:**
 ```shell
 docker run -it -v /datos --name ubuntu1 ubuntu bash  #Esto crea un volumen en /var/lib/docker/volumes 

 # . Si dentro de directorio /datos (contenedor) creamos un fichero, este se guardaria aqui -> /var/lib/docker/volumes/hash_volumen/_data o viceversa
 docker volume create nombre_del_volumen

 docker volume create vol1
 docker run -it --name ubuntuVol1 -v vol1:/dir1 ubuntu bash   #El volumen vol1 se monta en :/dir1 --> volumen:/directorio
 -v volumen:/directorio:ro  #ro es Read Only (solo lectura)

```
- **Compartir volumenes entre multiples contenedor**
```shell
docker run -it -v voluTest:/datos --name ubu4 ubuntu bash #Crear un volume y un contenedor
docker run -it --name ubu5 --volumes-from ubu4 ubuntu bash 
#Dentro del contenedor veremos los datos del volume que usa ubu4

root@950646871b92:/# ls 
bin  boot  datos  dev  etc  home  lib  lib64  media  mnt  opt  proc  root  run  sbin  srv  sys  tmp  usr  var
root@950646871b92:/# ls datos/
datos.txt
root@950646871b92:/# 


```
- **Compartir directorio entre contenedor y host**

```shell
docker run -it -v /ruta/directorio/host:/rutaContenedor --name Name image:tag #Esto comparte un directorio entre host y contenedor (montaje de tipo Bind)

```



- **Listar volúmenes:**
 ```shell
 docker volume ls
 docker volume inspect hash_volume
 docker volume inspect ab7385ca2e94d01c2803b600736201c3928f4bf94ecfc925baa7ecc18d945421 
```
### Interactuando con Contenedores

- **Ejecutar un comando en un contenedor en ejecución:**
 ```shell
 #docker exec -it nombre_del_contenedor comando, El comando exec ejecuta el comando y sale, con -it arranca terminal interactiva
docker exec -it localbillingApp sh

docker exec -it contenedorid bash
docker exec contenedorid comando   ejemplo:  docker exec pensive_perlman uname -a

```
- **docker attach**
 ```shell
#Muestra lo que es la salida estandar de los  contenedores en background. Me asocio al comando que se està ejecutando en ese momento en el contenedor
docker attach contenedorid

docker run --name ubuntu1 -d -it ubuntu top #ejecuta top 
docker attach ubuntu1 
```

- **Copiar archivos entre el host y un contenedor:**
 ```shell
  #Copia desde anfitrion a contenedor
  docker cp /ruta/archivo nombre_del_contenedor:/ruta/destino
  #Copiar desde contenedor a Sistema operativo principal
  docker cp contenedor:/ruta/archivo /destino
  ```
### Docker Compose

- **Iniciar contenedores definidos en un archivo `docker-compose.yml`:**
 ```shell
  docker-compose up
```
- **Escalar servicios en Docker Compose:**
 ```shell
  docker-compose scale servicio=num_instancias
```
- **Detener y eliminar contenedores definidos en Docker Compose:**
 ```shell
  docker-compose down
```
- **Ver logs de servicios en Docker Compose:**
 ```shell
  docker-compose logs servicio
```
### Administración de Redes y Volúmenes

- **Eliminar una red:**
 ```shell
  docker network rm nombre_de_la_red
```
- **Eliminar un volumen:**
 ```shell
  docker volume rm nombre_del_volumen
```
- **Inspeccionar una red:**
 ```shell
 docker network inspect nombre_de_la_red
```

- **Inspeccionar una imagen:**
 ```shell
 docker image inspect nombre_imagen
```

### Comandos para Información y Estadísticas

- **Ver detalles de un contenedor o imagen :**
 ```shell
  docker inspect nombre_del_contenedor
  docker inspect image_id
```
- **Obtener estadísticas de uso de recursos de un contenedor:**
 ```shell
  docker stats nombre_del_contenedor
```
- **Obtener estadísticas de uso de recursos de todos los contenedores:**
 ```shell
  docker stats
```
### Comandos para Seguridad y Control de Acceso

- **Crear un perfil de control de acceso (se requiere Docker EE):**
 ```shell
  docker trust key generate nombre_de_perfil
```
- **Especificar qué usuarios o equipos pueden o no usar Docker:**
 ```shell
  docker trust key load --alias nombre_de_perfil.pem --pem --root /etc/docker/pki/tls/private
```

- **Inhabilitar Docker para usuarios no autorizados (se requiere Docker EE):**
 ```shell
  docker trust signer remove nombre_de_perfil
```
### Comandos para Configuraciones Avanzadas


- **Crear un contenedor con un archivo de configuración personalizada y variable :**
 ```shell
  
  docker run -v ruta/local:/ruta/contenedor -e variable_de_entorno=valor nombre_de_la_imagen

  #Pasar variables de entorno mediante un archivo

  docker run -d --name mysql3 --env-file mysql.properties mysql
  docker run -d --name mysql3 --env-file archivo_con_varaibles imagen
```


- **Especificar recursos de sistema para un contenedor (CPU, memoria, etc.):**
 ```shell
 docker run --cpu-shares=512 -m 256m nombre_de_la_imagen
```
- **Elimina todos los contenedores detenidos e imagenes que no esten en uso**
 ```shell
docker system prune --all
 ```
 - **Elimina todos los volumenes que no esten en uso**
 ```shell
docker volume prune
 ```
 - **Elimina todas las redes que no esten en uso, menos las por defecto (bridge, none,host)**
 ```shell
docker network prune
 ```

  - **Visualizar logs de un contenedor**
 ```shell
docker logs contenedor_id | contenedor_nombre
docker logs quirky_euclid --tail 10 #ultimas 10 lineas 
docker logs contenedorid -f  #Mirar los logs de forma infinita
docker kill contenedorid  #para el contenedor y los procesos
 ```

  - **Systemctl opcion docker**
 ```shell
systemctl status docker 
systemctl start docker
systemctl enable docker
systemctl stop docker

 ```

  - **dockerd**
 ```shell
dockerd 
ps -ef | grep dockerd
 ```

 - **docker ps**
 ```shell
 docker ps -s -a (muestra dimensiones de los contenedores )
 docker ps -n int -n 4
 docker -f filtro de busqueda (mirar filtro en doc)
 ```

 - **docker run**
 ```shell
docker run --name nombre_contenedor image:tag
docker run --name micontenedor ubuntu:latest
docker run --name ubuntu2 -it ubuntu (modo interactivo, ejecutar comandos hasta que hacemos un exit y el contenedor se para)
docker run -d image (ejecuta en background y deja en funcion el contenedor si esto tiene tarea recursiva)

docker run --name micontenedor -d -it image

docker run -d -p 8081:80 nginx #(-p redirecciona puertos -p puerto_anfitrion:puerto_contenedor, -P mayuscula mapea puerto aleatorio)
curl http://localhost:8081 para probar la redireccion con peticion http

 ```

 - **docker start stop**
 ```shell
 docker start -i contenedorid | contenedornombre docker start -i mi_ubuntu (modo interactivo para un contenedor parado)
 docker stop contenedorid | contenedornombre
 ```


 - **Ver recursos contenedores**
 ```shell 
 docker top nobre_contenedor 
 docker stats nombre_contenedor
 docker ports contenedor_nombre
 ```


 - **System** 
 ```shell 
 Usage:  docker system COMMAND

Manage Docker

Commands:
  df          Show docker disk usage
  events      Get real time events from the server
  info        Display system-wide information
  prune       Remove unused data

 #Informacion sobre el sistema docker
 docker system info 
#Info sobre contenedores y memoria usada
  docker system df
#Saca logs / info sobre lo que pasa en el sistema docker (arranque contenedor, pull imagenes, destroy container...)
docker system events

 ```

 - **Link** 
 ```shell 
docker run -it --rm --name nombre --link contenedor:alias imagen:tag #Deprecated
docker run -it --rm --name b3 --link b1:maquina1 busybox:latest   #Enlaza el b1 desde el b3. Basicamente se agrega entrada a /etc/hosts.

 ```

  - **2 contenedores en una misma red**
```shell

docker run -d --name mysql_client -p 3101:3306 -e MYSQL_ROOT_PASSWORD=system --network red1 mysql 
docker run -d --name mysql_server -p 3100:3306 -e MYSQL_ROOT_PASSWORD=system --network red1 mysql 

#Los contenedores ahora se cominucan con nombres, puertos etc.. es decir no hacen falta configuraciones extra si se encuentran en la misma red

#Wordpress con entornos separados
docker run -d --name sqlwp --env-file mysql.properties --network red1 mysql:latest #Crear bd
docker run -d --name wp1 -p 9000:80 --network red1 --env-file wordpress.properties wordpress #Arrancar wp

```

- **Montaje de tipo tmpfs**
```shell
docker run -d -it --name Name --tmpfs /direcotrioContenedor imge:tag #Crear un direcotrio de tipo temporal, si el contenedor se para o se elimina los datos se borran 
```



- **Ver cambios en una imagen**
```shell
docker diff NameContainer 
A append
C change
D delete

#Ejemplo salida de diff
A /var/cache/debconf/templates.dat-old
C /var/cache/debconf/config.dat
A /var/cache/debconf/config.dat-old
C /var/cache/debconf/templates.dat
C /var/cache/ldconfig
C /var/cache/ldconfig/aux-cache

```

- **Crear imagen a partir de un contenedor**
```shell
docker commit NombreContenedor NombreImage #imagen lowercase, Esto crea un imagen nueva y se puede ver con docker image ls
#Por ejemplo si en un contenedor Ubu1 hemos instalado cosas adicionales podemos crear una imagen
docker commit Ubu1 ubuntu-wget
#La informacion se guarda en /var/lib/docker
``` 

- **Crear imagen con Dockerfile**
```shell
#crear un directorio 
#creamos Dockerfile
docker build -t nombreImagen:tag /ruta/Dockerfile

mkdir MiPython
vim Dockerfile
#Contenido
FROM ubuntu
RUN apt-get update
RUN apt-get install -y python3

docker build -t mipyth:1.0.0 /home/user/dock/MiPython/
```

- **Subir imagen a dockerhub**
```shell
docker login  -u usuario (autenticacin)
docekr push user/image:version
```
- **Empaquetar y desempaquetar imagen dentro de archivo tar**
# SAVE LOAD
```shell
docker image save image:tag -o archivo.tar
docker image save ubuntu:latest -o ubuimage.tar #tar tfv para ver el contenido del archvio
docker image load -i archivo.tar
```

- **Buscar imagenes**
# Docker search
```shell
docker search imgage
docker search image --filter is-official=ture
```