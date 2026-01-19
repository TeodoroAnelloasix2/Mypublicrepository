FROM ubuntu:22.04

ADD ./entrypoint.sh ./script/

RUN apt-get update && apt-get install apache2 -y && chmod +x ./script/entrypoint.sh


EXPOSE 80

CMD ["/bin/bash","./script/entrypoint.sh"]