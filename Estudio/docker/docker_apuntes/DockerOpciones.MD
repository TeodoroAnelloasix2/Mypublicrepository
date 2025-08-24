# Opciones docker


# Memoria 
```
-m o --memory=
Memoria máxima que puede usar el contenedor. Lo mismo se les asigna de swap.

--memory-swap
Límite total de memoria + swap (intercambio en disco) que puede usar el contenedor.

--memory-swappiness
Porcentaje de páginas anónimas que el sistema puede intercambiar. Valor entre 0 y 100.

--memory-reservation
Límite de memoria blando: se activa cuando hay poca memoria disponible en el host. Debe ser menor que --memory.

--kernel-memory
Límite de memoria del kernel que puede usar el contenedor. El mínimo es 6 MB. No se puede intercambiar, así que afecta directamente al sistema si se agota.

--oom-kill-disable
Desactiva el "OOM killer" que mata procesos cuando falta memoria. Solo debe usarse si también se define --memory.
```

```shell
docker run --rm -d --name apachetest1 -m 24MB httpd
docker stats

CONTAINER ID   NAME          CPU %     MEM USAGE / LIMIT   MEM %     NET I/O         BLOCK I/O        PIDS 
ad05559f6186   apachetest1   0.00%     11.91MiB / 24MiB    49.64%    7.01kB / 126B   6.66MB / 4.1kB   82 
                                            -m 24MB                        


#Como podemos ver en LIMIT se ha configurado 24MiB
```


# CPU
```
--cpus=<valor>
Cantidad de CPU asignada al contenedor. Por ejemplo, --cpus="1.5" limita al contenedor a 1.5 CPUs.

--cpu-period=<valor>
Período del planificador CFS, por defecto 100 000 microsegundos (100 ms). Se usa junto con --cpu-quota.

--cpu-quota=<valor>
Cuota de CPU en microsegundos por período. Si se supera, el contenedor es limitado. Usado con --cpu-period.

--cpuset-cpus
Restringe los núcleos específicos de CPU que puede usar el contenedor. Ej: 0-2 o 1,3.

--cpu-shares
Peso relativo del contenedor en el uso de CPU. Por defecto es 1024. Es un límite blando: solo afecta cuando hay competencia por CPU.
```

```shell
docker run --cpu-shares=1024 --cpuset-cpus=0-1 mysql
docker run --cpu-shares=512 --cpuset-cpus=0-1 httpd
docekr run --cpu-shares=2048 --cpuset-cups=0-1 ubuntu:latest

#Sobre los nucleos 0-1 asignamos las prioridades de cada contenedor
```

# File sistems 
```
| Driver          | Descripción                                                                                                                           |
|-----------------|------------------------------------------------------------------------------------------------------------------------------------   |
| overlay2        | Driver preferido en todas las distribuciones Linux actuales. No requiere configuración adicional.                                     |
| fuse-overlayfs  | Recomendado solo para usar Docker sin root (rootless) en sistemas antiguos sin soporte para overlay2. No necesario desde kernel 5.11. |
| btrfs y zfs     | Permiten opciones avanzadas como "snapshots", pero requieren configuración y mantenimiento adicional.                                 |
| vfs             | Solo para pruebas o entornos sin sistema de archivos copy-on-write. Tiene bajo rendimiento, no recomendado en producción.             |
```

```shell
#Cambiar tipo de file systems
#Backup docker 
systemctl stop docker
sudo cp -r /var/lib/docker backup/docker-backup/
sudo rm -rf /var/lib/docker
sudo zpool create -f zpool-docker -m /var/lib/docker  /dev/sdb #disco deseado

#editar
/etc/docker/daemon.json
{
    "storage-driver":"zfs"
}
systemctl start docker
```


# Política de reinicio

```
Política de reinicio de contenedores (--restart)

Al lanzar un contenedor con docker run, puedes indicar cómo debe comportarse si se detiene usando la opción --restart.

    no  (sin reinicio automático)
    No reinicia el contenedor en ningún caso. Es la opción predeterminada: si el proceso finaliza, Docker no hace nada más.

    on-failure[:max-retries]  (al fallar [reintentos máx.])
    Solo reinicia el contenedor cuando acaba con un código de salida distinto de 0 (error).
    Puedes limitar los intentos con :max-retries — por ejemplo, --restart on-failure:3 lo intentará tres veces como máximo.

    always  (siempre)
    Reinicia el contenedor cada vez que se detiene, sea cual sea la causa.
    Si lo paran manualmente con docker stop, no arranca de nuevo hasta que el daemon de Docker se reinicie o tú lo arranques explícitamente.

    unless-stopped  (a menos que se detenga)
    Funciona igual que always, salvo que respeta un paro manual: si detienes el contenedor, no volverá a levantarse ni siquiera después de reiniciar Docker o el servidor, a menos que tú lo inicies.
```
```shell
#Un contenedor por defecto, si cae no se vuelve  a levantar
parar.sh
#!/bin/bash
sleep 20
exit 1
```
**Este contenedor cada 20 segundo se cae**

```dockerfile
FROM ubuntu:latest

RUN mkdir ./testscript 

WORKDIR /testscript

COPY ./parar.sh .

RUN chmod +x parar.sh

CMD ["/bin/bash","./parar.sh" ]
```
# Propiedad always
```shell
docker run  -d --name c1 --restart always image  #El demonio docker siempre reinicia el contenedor. A menos que no se pare de forma manual o correcta
docker inspect c1
#Hay un campo donde poder ver los reinicio del contenedor
"RestartCount": 3,

docker run -d --name c1 --restart on-failure:2 pararimage:latest 
"RestartCount": 2,
"MaximumRetryCount": 2
```

# Archivos configuracion contenedores

```shell
 docker run -d --name c1 httpd
# salida -> f909fb56cc7457072c13a20a3015dfcc874e61b190f2aeeef0b88cfeab63732c
 sudo ls /var/lib/docker/containers/f909fb56cc7457072c13a20a3015dfcc874e61b190f2aeeef0b88cfeab63732c
checkpoints  config.v2.json  f909fb56cc7457072c13a20a3015dfcc874e61b190f2aeeef0b88cfeab63732c-json.log  hostconfig.json  hostname  hosts  mounts  resolv.conf  resolv.conf.hash
#Se crea un directorio que tiene como nombre el mismo hash de la salida del comnando docker y es ahi donde se guarda la informacion

#En el archivo XXXXXXXXXX-json.log se guardan los logs del contenedor 
#Opciones de los logs de los contenedores
https://docs.docker.com/engine/logging/configure/
```

```shell
#Cambiar de sistema de log con --log-driver
docker run --name c3 --log-driver=journald -d -p 9090:80 httpd
#Ver configuracion
docker inspect c3
#apartado LogConfig
```
```json

 "LogConfig": {
                "Type": "journald",
                "Config": {}
            }
```
```shell
#Ver los logs
journalctl CONTAINER_NAME=c3

jul 12 10:06:19 roothost 2e4475c3842c[1409]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this mes>
jul 12 10:06:19 roothost 2e4475c3842c[1409]: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 172.17.0.2. Set the 'ServerName' directive globally to suppress this mes>
jul 12 10:06:19 roothost 2e4475c3842c[1409]: [Sat Jul 12 08:06:19.961322 2025] [mpm_event:notice] [pid 1:tid 1] AH00489: Apache/2.4.63 (Unix) configured -- resuming normal operations
jul 12 10:06:19 roothost 2e4475c3842c[1409]: [Sat Jul 12 08:06:19.963432 2025] [core:notice] [pid 1:tid 1] AH00094: Command line: 'httpd -D FOREGROUND'
jul 12 10:12:10 roothost 2e4475c3842c[1409]: 172.17.0.1 - - [12/Jul/2025:08:12:10 +0000] "GET / HTTP/1.1" 200 45

```