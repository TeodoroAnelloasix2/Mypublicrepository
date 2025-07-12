
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