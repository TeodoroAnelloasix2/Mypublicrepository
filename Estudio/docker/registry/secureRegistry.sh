#!/bin/bash
#Se necesitan permisos root para ejecutar correctamente!
##Generamos una clave con certificado autofirmado
echo -e "\e[1;36m Creando certificados \e[0m"

mkdir -p ./certs

openssl req  -newkey rsa:4096 -nodes -sha256 -keyout ./certs/registry.key -x509 -days 365 -out ./certs/registry.crt  -subj "/CN=roothost/C=ES/ST=BCN/L=Barcelona/O=italianodev/OU=italianodev" -addext "subjectAltName = DNS:roothost"


if [[ -f "./certs/registry.key"  && -f "./certs/registry.crt" ]];then
  echo -e "\e[1;36m Certificados creados correctamente \e[0m"
else
  echo -e "\e[1;31m Error creando certificados, revisar \e[0m"
  exit 1
fi

echo -e "\e[1;36m Creando directorios de trabajo \e[0m"

##Creamos un directorio en este PATH que se llame como nuestro nodo:puerto
mkdir -p /etc/docker/certs.d/roothost:443

if [ $? -eq 0 ];then
  echo -e "\e[1;36m directorios creados \e[0m"
else
  echo -e "\e[1;31m Error creando directorios, revisar \e[0m"
  exit 1
fi

echo -e "\e[1;36m Copiando certificados \e[0m"

cp -f ./certs/registry.crt /etc/docker/certs.d/roothost:443

if [ -f "/etc/docker/certs.d/roothost:443/registry.crt" ];then
  echo -e "\e[1;36m Certificados copiados correctamente \e[0m"
else
  echo -e "\e[1;36m Error copiando certificados \e[0m"
  exit 1
fi

echo -e "\e[1;36m Generando credenciales \e[0m"

mkdir -p ./auth
mkdir -p ./imagenes_docker
#Generamos un fichero de usuario/password de tipo htpasswd
htpasswd -Bbn admin admin > ./auth/htpasswd

if [ -f "./auth/htpasswd" ];then
  echo -e "\e[1;36m Credenciales generadas correctamente \e[0m"
else
  echo -e "\e[1;36m Error generando credenciales \e[0m"
  exit 1
fi


##Generamos el contenedor
docker run -d -p 443:443 --restart=always --name registro_privado \
  -v ./imagenes_docker:/var/lib/registry \
  -v ./auth:/auth \
  -e REGISTRY_AUTH=htpasswd \
  -e REGISTRY_AUTH_HTPASSWD_REALM="Secure Registry" \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
  -e REGISTRY_HTTP_ADDR=0.0.0.0:443 \
  -v ./certs:/certs \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/registry.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/registry.key \
  registry
