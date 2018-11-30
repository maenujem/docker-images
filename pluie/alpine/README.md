# pluie/alpine

This Image provide a Linux Alpine distribution with :
- fully functionnal & colorized terminal
- bash
- curl
- nano as editor

Base image : [alpine:3.8](https://hub.docker.com/_/alpine/)

This project come with a structure to facilitate further images (like pluie/alpine-apache & pluie/alpine-mysql)

__note :__ wget ssl issue

apk add ca-certificates wget && update-ca-certificates
    

## Image Size

- very small image ~ 15 MB


## Image Usage

```
$ docker run --name alpine -it pluie/alpine
```

## Image Structure

```
project/
   |
   |-- install.d/   # deployed in /scripts on target container
   |      |         # launch on docker image building process
   |      |         # XX-name.sh - low XX are run first
   |      |-- 00-util.sh
   |      |-- 40-fix.sh
   |
   |-- pre-init.d/  # deployed in /scripts on target container
   |      |         # launch on docker container running process
   |      |-- 50-builder.sh
   |
   |-- build        # build docker image : ./build [TAG]
   |-- common.sh    # don't modify - sourced by main.sh to execute pre-init.d scripts first
   |-- install.sh   # don't modify - execute install.d scripts on docker building process
   |-- main.sh      # source common.sh then execute entry point instruction
   |-- util.sh      # sourced by common.sh
```

you can easily create your own images based on this structure.  
keep an eye to pluie/alpine-apache, pluie/alpine-apache-php7 & pluie/alpine-mysql wich extend pluie/alpine  


## Extend pluie/alpine Image

RUN instructions are minimized  
on extended image you only need to use :
```
RUN bash /scripts/install.sh
```
add your packages in a script in install.d directory  
keep name below 40 because install.d/40-fix.sh clean package repository  
each extended image inherit install.d && pre-init.d scripts

extended images doesn't need to define ENTRYPOINT  
you can keep intact build script in each extended project  
manage your install & init instruction in install.d & pre-init.d directory  
and write your own main.sh script  

Docker file example (from pluie/alpine-apache)

```
FROM pluie/alpine

MAINTAINER a-Sansara https://github.com/a-sansara

ADD files.tar /scripts

ENV      SHENV_NAME=Apache \
        SHENV_COLOR=67 \
   HTTP_SERVER_NAME=site.docker \
            WWW_DIR=www \
          WWW_INDEX=index.php \
      FIX_OWNERSHIP=1 \
                 TZ=Europe/Paris

EXPOSE 80

RUN bash /scripts/install.sh
```
