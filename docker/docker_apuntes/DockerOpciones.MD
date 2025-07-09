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