#!/bin/bash
# @app      pluie/alpine-apache
# @author   a-Sansara https://git.pluie.org/pluie/docker-images

apk update && apk add apache2 apache2-proxy apache2-proxy-html apache-mod-fcgid libxml2 \
php7-fpm \
php7 \
php7-phar \
php7-xml \
php7-opcache \
php7-mysqli \
php7-pdo_mysql \
php7-pdo \
php7-json \
php7-curl \
php7-gd \
php7-dom \
php7-iconv \
php7-mbstring \
php7-common \
php7-session \
php7-openssl \
php7-ctype \
php7-mcrypt \
php7-zlib \
php7-zip
# php7-cli
# php-pdo_odbc php-soap php-pgsql
