# Containerized PhpPgAdmin

Know more about what the software is at their [website](http://phppgadmin.sourceforge.net/doku.php%20phppgadmin).

Notes: 
 1. Container runs on openshift.
 2. For sharing sessions, please share the /var/lib/php accross the containers with appropriate permissions
 3. You can provide your own custom config by mounting same into /etc/phpPgAdmin/config.inc.php. Just bear in mind, file permissions.

## Environment variables

 1. POSTGRESQL_SERVER - The ip or reachable address of the postgresql database to connect to

## Build container

    $ docker build -t registry.centos.org/centos/phppgadmin:latest -f Dockerfile .

## Sample usage

###Run Postgresql:

    $ docker run -e POSTGRESQL_USER=myuser -e POSTGRESQL_PASSWORD=myuser -e POSTGRESQL_DATABASE=myuser -d registry.centos.org/postgresql/postgresql:9.6

###Run phppgadmin

    $ docker run -e POSTGRESQL_SERVER="<postgresql_ip>" -d registry.centos.org/centos/phppgadmin:latest 
