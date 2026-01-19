FROM ubuntu:22.04

RUN apt-get update && apt install -y python3 && mkdir /personal \
&& mkdir /personal/docsContenedor

WORKDIR /personal

COPY ./program.py .


ADD ./docsHost/d* docsContenedor

CMD ["python3","program.py"]