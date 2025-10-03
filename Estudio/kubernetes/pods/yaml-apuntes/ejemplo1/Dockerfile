FROM nginx:alpine

LABEL manteiner="italianodev" version="1.0.0" descripcion="Imagen de ejemplo para kubernetes!"

RUN echo "Imagen test para kubernets :)" > index.html \
    && mv index.html /usr/share/nginx/html/index.html

ENTRYPOINT [ "nginx","-g","daemon off;" ]

EXPOSE 80
