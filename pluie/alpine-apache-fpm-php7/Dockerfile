# @app      pluie/alpine-apache-fpm-php7
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

# FROM pluie/alpine:latest
FROM maenujem/alpine:latest

MAINTAINER maenujem https://github.com/maenujem

ADD files.tar /scripts

ENV      SHENV_NAME=ApacheFpm \
        SHENV_COLOR=67 \
   HTTP_SERVER_NAME=fpm.docker \
            WWW_DIR=www \
          WWW_INDEX=index.php \
      FIX_OWNERSHIP=1 \
                 TZ=Europe/Paris

EXPOSE 80

VOLUME /etc/php7/fpm.d/

RUN bash /scripts/install.sh
