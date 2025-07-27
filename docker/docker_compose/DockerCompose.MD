
# Apuntes docker compose 

**Ejemplo 1**

# Apuntes docker compose 

**Ejemplo 1**

```yaml
version: '3'       # Versión del esquema de Docker Compose (define sintaxis y funcionalidades) Deprecated
services:          # Inicio de la sección donde se definen los servicios (contenedores) de la aplicación
  nginx:           # Nombre del servicio; identifica este contenedor dentro del proyecto
    image: nginx   # Imagen Docker que se usará para este servicio (en este caso, la oficial de nginx)
    ports:         # Define el mapeo de puertos entre el host y el contenedor
      - "8080:80"  # Mapea el puerto 80 del contenedor al puerto 8080 del host para acceso externo
```

```shell
docker compose up  #Arranca los servicios presentes en el .yml
docker compose up -d #Arranca en background
docker compose start #Vuelve a lanzar los servicios parados
docker compose stop #Para los servicios sin eliminar
docker compose down #Para y elimina los servicios

```

```shell
docker compose logs #Logs de todos los servicios
docker compose logs servicio #Logs del servicio, service: svc-apache el del yaml
docker compose top  #Servicios que mas recursos cosumen
docker compose top servicio 
docker compose events  #Eventos relevantes 

```

```shell
docker compose pause servicio #Pausar servicio
docker compose unpause servicio #Volver a arrancar el servicio
docker compose rm servicio #Eliminar servicio

```
```shell
docker compose -p nombre_proyecto up -d #Define el nombre del proyecto (por defecto es el nombre del directorio de trabajo). Afecta al prefijo de contenedores, redes, etc..
docker compose -p nomnre_proyecto ps #Visualizar los contenedores del proyecto especificado
#docker compose ps por defecto busca a los contenedores con prefijo del directorio de trabajo
docker-compose -p proyecto -f /ruta/al/docker-compose.yml ps # Antiguo es necesario especificar la ruta al compose.yml si no es el directorio de trabajo del proyecto
docker compose -p proyecto down
```
# Ejemplo 2 

```yaml
services:
  web:
    build: . # Ruta al Dockerfile (contexto de construcción)
    image: usuariodockerhub/imagename:1.0.0 # Nombre de la imagen en formato Docker Hub (usuario/imagen:tag)
    container_name: web_frontal # Nombre del contenedor, útil para resolución DNS entre servicios
    ports:
      - "8080:80" # Redireccionamiento de puertos (host:contenedor)

```

**Nota**
```
El archivo que se intenta buscar primero es, por defecto, compose.yaml
```

# Variables de entorno en YAML
```yaml
services:
  database:
    image: mysql
    restart: always #Politica de reinicio contenedor
    enviroment: #Configurar las variables de entorno
      MYSQL_DATABESE: dbname 
      MYSQL_USER: username
      MYSQL_PASSWORD: userpassword
      MYSQL_ROOT_PASSWORD: rootpassword

```
**Alternativa**
```yaml
 env_file:
    - ./ruta/mysql.properties
```

**COnfigurar dependiecias**
```
A veces necesitamos que se arranque antes un servicio y luego otro, por ejemplo: 
- 1 base de datos 
- 2 wordpress
```

```yaml
   depends_on:  #Espera que se arranque primero el servicio  especificado
      - db-wp1
```

# VOLUMES

```yaml
services:
  wordpress:
    image: wordpress
    restart: always
    ports:
      - 9090:80
    environment:
      WORDPRESS_DB_HOST: db-wp1  #Tiene que coincidir con el servicio del host que aloja la bbdd
      WORDPRESS_DB_USER: wp-user 
      WORDPRESS_DB_PASSWORD: lepanto
      WORDPRESS_DB_NAME: wp-db
    depends_on:     
      - db-wp1
    volumes:
      - /var/www/html
  
  db-wp1:
    image: mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_USER: wp-user
      MYSQL_PASSWORD: lepanto
      MYSQL_DATABASE: wp-db
    volumes:
      - /var/lib/mysql

```
**Named Volumes**
```yaml
    volumes:
      - wp:/var/lib/mysql # - nombre_del_volumes:/ruta/volumes
```

```yaml
services:
  wordpress:
    image: wordpress
    restart: always
    ports:
      - 9090:80
    environment:
      WORDPRESS_DB_HOST: db-wp1  #Tiene que coincidir con el servicio del host que aloja la bbdd
      WORDPRESS_DB_USER: wp-user 
      WORDPRESS_DB_PASSWORD: lepanto
      WORDPRESS_DB_NAME: wp-db
    depends_on:     
      - db-wp1
    volumes:
      - wp:/var/www/html
  
  db-wp1:
    image: mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_USER: wp-user
      MYSQL_PASSWORD: lepanto
      MYSQL_DATABASE: wp-db
    volumes:
      - db:/var/lib/mysql # - nombre_del_volumes:/ruta/

volumes: #Declarar los volumenes para que esten disponibles para todos los servicios
  wp:
  db:
```
**Bind Volumes**

```yaml
    volumes:
      - /home/itachi/Personal/wp1_volume:/var/www/html #/ruta/sistema:/ruta/contenedor
```
```shell
 ls /home/itachi/Personal/wp1_volume/
```
```
Salida: 

index.php    readme.html      wp-admin            wp-comments-post.php  wp-config.php         wp-content   wp-includes        wp-load.php   wp-mail.php      wp-signup.php     xmlrpc.php
license.txt  wp-activate.php  wp-blog-header.php  wp-config-docker.php  wp-config-sample.php  wp-cron.php  wp-links-opml.php  wp-login.php  wp-settings.php  wp-trackback.php

```
```json
"Mounts": [
    {
        "Type": "bind",
        "Source": "/home/itachi/Personal/wp1_volume",
        "Destination": "/var/www/html",
        "Mode": "rw",
        "RW": true,
        "Propagation": "rprivate"
    }
]
```

```json
"Mounts": [
            {
                "Type": "volume",
                "Name": "b13a62ccc0f2329766b618a95093b972317d0c67a5131101fd89c3e7ebdacf70",
                "Source": "/var/lib/docker/volumes/b13a62ccc0f2329766b618a95093b972317d0c67a5131101fd89c3e7ebdacf70/_data",
                "Destination": "/var/www/html",
                "Driver": "local",
                "Mode": "z",
                "RW": true,
                "Propagation": ""
            }
]
```
```
datos
var/lib/docker/volumes/b13a62ccc0f2329766b618a95093b972317d0c67a5131101fd89c3e7ebdacf70/_data# ls
index.php    wp-activate.php     wp-comments-post.php  wp-config-sample.php  wp-includes        wp-login.php     wp-signup.php
license.txt  wp-admin            wp-config-docker.php  wp-content            wp-links-opml.php  wp-mail.php      wp-trackback.php
readme.html  wp-blog-header.php  wp-config.php         wp-cron.php           wp-load.php        wp-settings.php  xmlrpc.php
```


# Networks

```yaml
services:
  svc-apache:
    image: httpd
    networks:
      - frontal  #Asignar el servicio a la red
    ports:
      - 80:80
  
  svc-tomcat:
    image: tomcat
    networks:
      - frontal
      - red_secundaria #Un contenedor puede estar en varias redes
    ports:
      - 8080:8080
networks: #Declaro las redes
  frontal:
    name: frontal  # Nombre para la red no lo crea el demonio docker, se usa el especificado
    driver: bridge
  red_secundaria:
    name: red_secundaria
    driver: bridge

```

# Alias

```
Crear un alias para referenciar a un contenedor 
```
```yaml
    volumes:
      - wp:/var/lib/mysql # - nombre:/ruta/volumes
```

```yaml
services:
  wordpress:
    image: wordpress
    restart: always
    ports:
      - 9090:80
    environment:
      WORDPRESS_DB_HOST: alias1  #Uso el alias: nombre del host (alias del contenedor mysql en la red)
      WORDPRESS_DB_USER: wp-user 
      WORDPRESS_DB_PASSWORD: lepanto
      WORDPRESS_DB_NAME: wp-db
    depends_on:     
      - db-wp1 # Referencia al servicio
    volumes:
      - wp:/var/www/html
    networks:
      - wp-network
  
  db-wp1:
    image: mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root
      MYSQL_USER: wp-user
      MYSQL_PASSWORD: lepanto
      MYSQL_DATABASE: wp-db
    volumes:
      - db:/var/lib/mysql 
    networks:
      wp-network:
        aliases:
          - alias1 #Declarar un alias dentro de la red


volumes: #Declarar los volumenes para que esten disponibles para todos los servicios
  wp:
  db:
networks:
  wp-network:
    driver: bridge
```



