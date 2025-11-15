# Configurar jenkins con docker

### Basado en la guia oficial de jenkins

## 1 Crear red

```shell
docker network create jenkins-net
```
## 2 descargar imagen 
```shell
docker image pull docker:dind
```

## 3 Crear un docker:dind
```
contenedor docker que puede ejecutar comandos docker
```
```shell
docker run \
  --name jenkins-docker \
  --rm \
  --detach \
  --privileged \
  --network jenkins-net \
  --network-alias docker \
  --env DOCKER_TLS_CERTDIR=/certs \
  --volume jenkins-docker-certs:/certs/client \
  --volume jenkins-data:/var/jenkins_home \
  --publish 2376:2376 \
  docker:dind \
  --storage-driver overlay2
```

## 4 Construir imgen de  jenkins
```shell
docker build -t myjenkins-blueocean:2.528.2-1 .
```

## 5 Lanzar jenkins 

```shell
docker run \
  --name jkns \
  --restart=on-failure \
  --detach \
  --network jenkins-net \
  --network-alias jkns \
  --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client \
  --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 \
  --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  myjenkins-blueocean:2.528.2-1
```

### Resultado
```shell
docker ps
CONTAINER ID   IMAGE                           COMMAND                  CREATED         STATUS         PORTS                                                                                          NAMES
998326adb7fc   myjenkins-blueocean:2.528.2-1   "/usr/bin/tini -- /u…"   2 minutes ago   Up 2 minutes   0.0.0.0:8080->8080/tcp, [::]:8080->8080/tcp, 0.0.0.0:50000->50000/tcp, [::]:50000->50000/tcp   jkns
75a720a1f59b   docker:dind                     "dockerd-entrypoint.…"   4 minutes ago   Up 4 minutes   2375/tcp, 0.0.0.0:2376->2376/tcp, [::]:2376->2376/tcp                                          jenkins-docker
```


## Primera password por defecto

```shell
docker logs jkns

# En el output se encuentra la passwd!
[LF]> 
[LF]> Jenkins initial setup is required. An admin user has been created and a password generated.
[LF]> Please use the following password to proceed to installation:
[LF]> 
[LF]> *************************
[LF]> 
[LF]> This may also be found at: /var/jenkins_home/secrets/initialAdminPassword
```