FROM ubuntu:22.04

#Installing server ssh
RUN apt-get update && apt-get install -y openssh-server 

RUN useradd -m userdemo && \
sleep 1 && \
mkdir -p /home/userdemo && \
chown -R userdemo:userdemo /home \
&& chmod 750 -R /home && \
mkdir -p /home/userdemo/.ssh && \
chown userdemo:userdemo /home/userdemo/.ssh && chmod 700 /home/userdemo/.ssh 

WORKDIR /home/userdemo

COPY keydir/llavedemo1.pub .ssh/authorized_keys
COPY stillalive.sh .

RUN chmod 600 .ssh/authorized_keys && chown userdemo:userdemo .ssh/authorized_keys && \
chmod +x stillalive.sh

#Directory to send files
RUN mkdir -p pool && chmod 777 pool

RUN mkdir -p /run/sshd


EXPOSE 22


CMD ["/bin/bash","stillalive.sh"]

