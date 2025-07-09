FROM ubuntu

RUN apt-get update && apt-get install -y nginx

VOLUME /var/www/html 

ADD web /var/www/html 

ENTRYPOINT [ "/usr/sbin/nginx","-g","daemon off;" ]

EXPOSE 80
