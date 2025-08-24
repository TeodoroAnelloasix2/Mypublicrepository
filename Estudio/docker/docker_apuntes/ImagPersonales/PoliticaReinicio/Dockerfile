FROM ubuntu:latest

RUN mkdir ./testscript 

WORKDIR /testscript

COPY ./parar.sh .

RUN chmod +x parar.sh

CMD ["/bin/bash","./parar.sh" ]