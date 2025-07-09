FROM ubuntu
RUN apt-get update && apt-get install -y python3 git vim iputils-ping \
&& echo "1.0.0" >> ./version

ENV usuario1="El Italiano" usuario2="Gopher" usuario3=python3 
ENV  texto="Esto es un valor por defecto"

ENTRYPOINT ["/bin/sh", "-c"]

CMD ["echo \"Welcome to this container $usuario1 $usuario2 $usuario3 El texto es $texto\""]

