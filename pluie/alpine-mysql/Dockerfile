# @app      pluie/alpine-mysql
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

# FROM pluie/alpine:latest
FROM maenujem/alpine:latest

MAINTAINER maenujem https://github.com/maenujem

ADD files.tar /scripts

ENV  SHENV_NAME=Mysql \
    SHENV_COLOR=132

EXPOSE 3306

VOLUME ["/var/lib/mysql", "/dump"]

RUN bash /scripts/install.sh
