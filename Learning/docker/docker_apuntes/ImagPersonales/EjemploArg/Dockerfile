FROM ubuntu:22.04

ARG dir2
RUN mkdir "$dir2"
WORKDIR ${dir2}
ARG user
ENV user_docker="$user"
ADD ./adduser.sh .
RUN chmod +x adduser.sh

CMD ["/bin/bash","adduser.sh"]