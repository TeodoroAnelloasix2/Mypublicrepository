# Docker registry

### Repositorio personal


```
Docker registry es una imagen que nos permite levantar un contenedor, el cual guardará nuestras imágenes en un registro privado.

Es la aplicación oficial de Docker para tener un registro privado de imágenes.
Al levantar el contenedor con la imagen registry creamos un servicio HTTP que almacena imágenes Docker.
Funciona como “Docker Hub” pero es privado.
```


## Levantar el contenedor 

```shell
docker run -d --name registry -p 5000:5000 --restart always registry

#Con volume personal
docker volume create personal_volume
docker run -d --name registry2 -p 5001:5000 --restart always -v personal_volume:/var/lib/registry registry
```


## Subir imagen al repositorio

```shell

# Etiquetar la imagen para el registro privado
docker tag image host:puerto/image
docker tag bbddpersonal1:1.0.1 localhost:5000/bbddpersonal1:v1


# Imagenes
docker image ls
bbddpersonal1                  1.0.1               5739328cf148   2 months ago   859MB
localhost:5000/bbddpersonal1   v1                  5739328cf148   2 months ago   859MB

# Subir la imagen al registro

docker push localhost:5000/bbddpersonal1:v1 
The push refers to repository [localhost:5000/bbddpersonal1]
914a8e168aa0: Pushed 
f5e36b0f4d12: Pushed 
d619ee1b5c20: Pushed 
133ce0df5d7c: Pushed 
e1c1cbc5e82d: Pushed 
510a7371e11f: Pushed 
bdcd7807cb3e: Pushed 
ee80289a1f0f: Pushed 
a655f286e2fd: Pushed 
6fbd0dc178dd: Pushed 
30cef8a08884: Pushed 
v1: digest: sha256:1a4f5abe1ee20ce34f89962c3823c5fb25e4ff60fc4ef9d30ecffc752c1a41db size: 2619

```
```
La imagen se guarda en el volume  -> /var/lib/docker/volumes/e0f7348805f8b212af20bb745dc00a6a35aac57b3b40a0e615e6dfc3cefb5af2/_data/docker/registry/v2# ls
blobs  repositories

Cómo se organiza el almacenamiento ?

Docker Registry organiza los datos en dos directorios principales:

blobs/
Aquí se guardan las capas de las imágenes.
Cada capa es un archivo comprimido identificado por su hash (digest).
Si subes otra imagen que reutiliza las mismas capas, no se duplican: Docker Registry solo guarda una copia y reutiliza.

repositories/
Aquí se guardan las referencias (tags) que apuntan a esas capas.

```

## Descargar imagenes

```shell
docker pull localhost:5000/bbddpersonal1:v1

v1: Pulling from bbddpersonal1
Digest: sha256:1a4f5abe1ee20ce34f89962c3823c5fb25e4ff60fc4ef9d30ecffc752c1a41db
Status: Downloaded newer image for localhost:5000/bbddpersonal1:v1
localhost:5000/bbddpersonal1:v1
```

## Registry inseguro

```
Por defecto, Docker bloquea el acceso a registros privados que no utilizan protocolo HTTPS.
Para permitir el uso de un registro inseguro (HTTP), es necesario configurar el demonio de Docker en el archivo:
/etc/docker/daemon.json

```

```json
//Agregar esta opcion 
{
  "insecure-registries": ["remote-server-name:5000", "machine-name:port", "machine2:port"]
}
```
```shell
sudo systemctl restart docker
```

## API 

```
official document

https://docker-docs.uclv.cu/registry/spec/api/
```