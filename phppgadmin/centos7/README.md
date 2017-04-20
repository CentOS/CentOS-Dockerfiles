# Containerized PhpPgAdmin

Know more about what the software is at their [website](http://phppgadmin.sourceforge.net/doku.php%20phppgadmin).

Note container runs on openshift.

## Environment variables

 1. POSTGRESQL_SERVER - The ip or reachable address of the postgresql database to connect to

## Build container

    $ docker build -t registry.centos.org/centos/phppgadmin:latest -f Dockerfile .

## Sample usage

###Run Postgresql:

    $ docker run -e POSTGRESQL_USER=myuser -e POSTGRESQL_PASSWORD=myuser -e POSTGRESQL_DATABASE=myuser -d registry.centos.org/postgresql/postgresql:9.6

###Run phppgadmin

    $ docker run -e POSTGRESQL_SERVER="<postgresql_ip>" -d registry.centos.org/centos/phppgadmin:latest 
