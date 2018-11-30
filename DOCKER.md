## Docker tips

### Networking

#### create network
```
docker network create \
--subnet=172.22.0.0/16 \
--gateway=172.22.0.1 \
-o "com.docker.network.bridge.name"="home0" \
home0
```

#### inspect ip
```
docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container
```

#### /etc/hosts
```
# > DOCKER - bridge home0
172.22.0.2	db.docker
172.22.0.3	gogs.docker
172.22.0.4	pma.docker
172.22.0.5	bo-payment.docker
172.22.0.6	wordpress.docker
172.22.0.7	fpm.docker
172.22.0.8	symfony.docker
172.22.0.9	php7.docker
# <

```

### Util

#### remove all container
```
docker rm $(docker ps -a -q)
```
rm -v to also remove volume  
rm -f to force stop running container before removing


#### remove none images
```
docker rmi $(docker images | grep "^<none>" | awk "{print \$3}")
```

#### remove all volumes
```
docker volume rm $(docker volume ls -qf dangling=true)
```

#### logs container
```
docker logs -f container
```

#### stats container
```
docker stats container
```

### Pluie container

#### map

[db.docker](http://db.docker)  
[pma.docker](http://pma.docker)  
[gogs.docker](http://gogs.docker)  
[bo-payment.docker](http://bo-payment.docker)  
[wordpress.docker](http://wordpress.docker)  
[fpm.docker](http://symfony.docker)  
[symfony.docker](http://symfony.docker)  

#### Mysql
```
cd /home/dev/docker

docker run --name mysql --restart=always \
--net home0 -h db.docker --ip 172.22.0.2 \
-v $(pwd)/db/mysql:/var/lib/mysql \
-v $(pwd)/db/dump:/dump \
-e MYSQL_DATABASE=bo-payment \
-e MYSQL_USER=dev \
-e MYSQL_PASSWORD=mysql \
-d pluie/alpine-mysql
```

#### Gogs
```
cd /home/dev/docker

docker run --name gogs --restart=always \
--net home0 -h gogs.docker --ip 172.22.0.3 --link mysql:db \
-v $(pwd)/gogs:/data \
gogs/gogs
```

#### Phpmyadmin
```
docker run --name pma --restart=always \
--net home0 -h pma.docker --ip 172.22.0.4 --link mysql:db \
-d phpmyadmin/phpmyadmin
```

#### Apache
```
cd /home/dev/docker

docker run --name apache --restart=always \
--net home0 -h bo-payment.docker --ip 172.22.0.5 --link mysql:db \
-v $(pwd)/repo/bo-payment:/app \
-e HTTP_SERVER_NAME=bo-payment.docker \
-d pluie/alpine-apache
```

#### Apache Php7
```
cd /home/dev/docker

docker run --name php7 --restart=always \
--net home0 -h bo-payment.docker --ip 172.22.0.9 --link mysql:db \
-v $(pwd)/repo/pws-server:/app \
-e HTTP_SERVER_NAME=bo-payment.docker \
-e WWW_DIR=web \
-d pluie/alpine-apache-php7
```

#### Wordpress
```
cd /home/dev/docker

docker run --name wordpress --restart=always \
--net home0 -h wordpress.docker --ip 172.22.0.6 --link mysql:db \
-v $(pwd)/repo/blog:/app \
-e HTTP_SERVER_NAME=wordpress.docker \
-d pluie/alpine-apache
```

#### ApacheFpm
```
cd /home/dev/docker

docker run --name afpm --restart=always \
--net home0 -h fpm.docker --ip 172.22.0.7 --link mysql:db \
-v $(pwd)/repo/afpm:/app \
-e HTTP_SERVER_NAME=afpm.docker \
-d pluie/alpine-apache-fpm
```

### Symfony
```
cd /home/dev/docker
docker run --name symfony --restart=always \
--net home0 -h symfony.docker --ip 172.22.0.8 --link=mysql:db \
-e HTTP_SERVER_NAME=symfony \
-e SYMFONY_VERSION=2.8 \
-v $(pwd)/repo/myapp:/app \
-d pluie/alpine-symfony
```

### Symfony Php7
```
cd /home/dev/docker
docker run --name symfony --restart=always \
--net home0 -h symfony.docker --ip 172.22.0.8 --link=mysql:db \
-e HTTP_SERVER_NAME=symfony \
-e SYMFONY_VERSION=3.2 \
-v $(pwd)/repo/myapp:/app \
-d pluie/alpine-symfony-php7
```
