# pluie/alpine-apache-fpm-php5

Extend pluie/alpine with __apache 2.4.35__ and __php 5.6.37__ with FPM

- you can use env var at container creation : __HTTP_SERVER_NAME__ (default : fpm.docker ortherwise edit app/vhost later)


## Image Size

- image ~ 50 MB

## ENV variables

```
 HTTP_SERVER_NAME=fpm.docker    # apache ServerName  
          WWW_DIR=www           # DocumentRoot relative to volume  
        WWW_INDEX=index.php     # DirectoryIndex
    FIX_OWNERSHIP=1             # 
```

### Inherit ENV variables

```
        SHENV_CTX=LOCAL         # LOCAL|INT|PROD change context bg color
       SHENV_NAME=ApacheFpm     # container name 
      SHENV_COLOR=67            # ANSI EXTENDED COLOR CODE
               TZ=Europe/Paris  # TIMEZONE
```

## Image Volumes

pluie/alpine-apache-fpm has two volumes :

- __/app__ to bind to your app project (silex/symfony etc)  
- __/etc/php5/fpm.d/__ to customize fpm 

### note

__/app/$WWW_DIR__ is the documentRoot.  
put only your entry point and static files to the documentRoot directory, no your app sources
(__/app__ directory is design for this).

__/app/vhost__ is your app vhost configuration file (with a serverName directive).
by default it use the apache rewrite module to redirect all uri to entry point $WWW_INDEX 



```
/app/              # your application directory
  |
  |---- $WWW_DIR/  # documentRoot
  |
  |---- vhost      # apache app vhost
```


## Image Usage

chdir to your project directory
```
$ docker run --name afpm -it --link=mysql:db -v $(pwd):/app pluie/alpine-apache-fpm
```
or
```
$ docker run --name afpm -d --link=mysql:db -e HTTP_SERVER_NAME=yourServerName -v $(pwd):/app pluie/alpine-apache-fpm
```


## Controling http server

```
# reload
$ docker exec -it afpm "httpd -k graceful"
# restart
$ docker exec -it afpm "httpd -k restart"
```
for more commands :
```
$ docker exec -it afpm "httpd -h"
```
