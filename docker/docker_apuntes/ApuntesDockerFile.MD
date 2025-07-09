# FROM
# 🌟 Imagen base
**FROM** ubuntu  From indica la base de la imagen desde donde partimos

# RUN
# 📦 Instalación de paquetes y creación de un archivo version
**RUN** apt-get update && apt-get install -y python3 git vim iputils-ping \  # Run ejecuta comandos
    && echo "1.0.0" >> ./version     

# CMD
# 🚀 Comando por defecto al iniciar el contenedor
**CMD** ["echo", "-e", "Welcome to this container"]  # cmd es el comando por defecto del contenedor ["ejecutable","param1","param2"...]

# ENTRYPOINT
# 🎯 Configura un entrypoint para concatenar argumentos
**ENTRYPOINT** ["df"]  # ENTRYPOINT puede concatenar argumentos al comando

# 🚀 Ejecución del contenedor con df -h
docker run -it --rm helloworld:1.0.1 -h

# Resultado esperado:
```shell
Filesystem      Size  Used Avail Use% Mounted on
overlay         457G   30G  405G   7% /
tmpfs            64M     0   64M   0% /dev
shm              64M     0   64M   0% /dev/shm
/dev/nvme0n1p2  457G   30G  405G   7% /etc/hosts
tmpfs           2.9G     0  2.9G   0% /proc/asound
tmpfs           2.9G     0  2.9G   0% /proc/acpi
tmpfs           2.9G     0  2.9G   0% /proc/scsi
tmpfs           2.9G     0  2.9G   0% /sys/firmware
tmpfs           2.9G     0  2.9G   0% /sys/devices/virtual/powercap
```

# WORKDIR
# 📁 Establece el directorio de trabajo
```dockerfile
WORKDIR /personal #WORKDIR establece el directorio de trabajo
```

# COPY
# 📥 Copia archivos al contenedor
```dockerfile
COPY ./program.py ./ruta/contenedor   #Copia archivoHost /ruta/contenedor
# Si tengo un index.html en local y quiero copiarlo:
# COPY /local/index.html /ruta/contenedor
```
# 🐍 Imagen con Python y contenido adicional
**FROM** ubuntu:22.04

**RUN** apt-get update && apt install -y python3 && mkdir /personal

**WORKDIR** /personal

**COPY** ./program.py .

**CMD** ["python3", "program.py"]


# ADD
# 📤 Añade más contenido (archivos y directorios) 
**ADD** ../docsHst/d* /personal/docsContenedor
**ADD** docs.tar .  # ADD es similar a COPY pero también permite traer cosas desde internet



# 🌍 Docker - Uso de ENV,ARG, ENTRYPOINT y CMD

## 📌 Definir variables de entorno con `ENV`
Permite establecer variables de entorno que estarán disponibles dentro del contenedor.
Establecer valor con -e  -> docker run -it --rm -e texto="Ya he cambiado el texto" imagetest2:latest

```dockerfile
ENV usuario1="El Italiano" usuario2="Gopher" usuario3=python3
ENV texto="Esto es un valor por defecto"


```

# ARG ⚙️
ARG permite pasar variables mientras se construye la imagen

Uso: docker build -t argimage:1.0.0 --build-arg dir2=data2 --build-arg user=test .

Es util para definir una variable mientras se contruye la imagen y luego se puede pasar a una variable de ENTORNO con ENV

```dockerfile
ARG dir2
RUN mkdir $dir2 
ARG user
ENV docker_user=$user
RUN useradd $docker_user 

```

# **EXPOSE** 🐳
Permite exponer puertos del contenedor
Indica qué puerto(s) del contenedor están disponibles para la comunicación externa.
# No realiza el mapeo directamente, solo lo declara (útil como documentación e integración con otras herramientas).
```dockerfile
EXPOSE 80 3306 
```

# VOLUME 📁
🧱 Docker crea volúmenes  automáticamente cuando se ejecuta un contenedor basado en esta imagen.
El contenedor asignará automáticamente un volumen anónimo para el directorio declarado.


```dockerfile
FROM ubuntu:22.04
ADD ./entrypoint.sh ./script/
RUN apt-get update && apt-get install apache2 -y
ADD ./pagina /var/www/html #contendido pagina: mages  index.html  style.css 
VOLUME ["/var/www/html"]
RUN chmod +x ./script/entrypoint.sh
EXPOSE 80
CMD ["/bin/bash","./script/entrypoint.sh"]
```

```shell
docker build -t ejemplovolume .
docker run -it --rm -p 8080:80 --name c1 ejemplovolume
docker run -it --rm  --name c2 -p 8081:80 --volumes-from c1 ejemplovolume
```

# **LABEL** 🏷️
Permite agregar metadatos al contenedor
Sirve para describir información sobre la imagen (autor, versión, descripción, etc.).
# Es útil para documentación, automatización y organización de imágenes en repositorios.
```dockerfile
LABEL maintainer="juan@example.com" version="1.0" description="Imagen de ejemplo con metadatos"
```