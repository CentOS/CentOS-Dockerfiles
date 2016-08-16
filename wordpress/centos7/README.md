dockerfiles-centos-wordpress
========================

(note: This originated from [jbfink](https://github.com/jbfink). I ported over to CentOS 7.)

Tested on Docker 1.0.0

(note: [Eugene Ware](http://github.com/eugeneware) has a Docker wordpress container build on nginx with some other goodies; you can check out his work [here](http://github.com/eugeneware/docker-wordpress-nginx).)

When you run the below commands, simply use sudo. This is a [known issue](https://twitter.com/docker/status/366040073793323008).)

This repo contains a recipe for making a [Docker](http://docker.io) container for Wordpress, using Linux, Apache and MySQL on CentOS7. 
To build, make sure you have Docker [installed](http://www.docker.io/gettingstarted/), clone this repo somewhere, and then run:

dockerfiles-centos-wordpress-mariadb
====================================

This dockerfile creates wordpress image that is based on CentOS and
utilizes a centos/mariadb container for a database.

Build
-----

To build the wordpress container simply:

```
docker build -t <yourname>/wordpress:centos7 .

```

Setup Database
--------------

First get the mariadb container up and running:

```
VOLUME='-v /var/lib/mysql'
DATABASE=mydb
USER=myuser
PASSWORD=password
ROOTPASS=rootpass
docker run -d                        \
    -e MYSQL_USER=$USER              \
    -e MYSQL_PASSWORD=$PASSWORD      \
    -e MYSQL_DATABASE=$DATABASE      \
    -e MYSQL_ROOT_PASSWORD=$ROOTPASS \
    $VOLUME --name=mariadb centos/mariadb
```
NOTE:: If you don't want a VOLUME then don't assign the variable

Run wordpress
-------------

Next start the wordpress with the db container linked:

```
docker run --link=mariadb:db -d --name wordpress -p 8080:8080 <yourname>/wordpress
```

Now connect to wordpress on localhost:8080 from your browser.


