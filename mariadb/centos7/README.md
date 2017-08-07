MariaDB Dockerfile
==================

Based on CentOS7 original mariadb Dockerfile, based on Stephen Tweedie's mariadb Dockerfile...

This repo contains a recipe for making Docker container for mariadb on CentOS7.

Setup
-----

Check your Docker version

    # docker version

Perform the build

    # docker build --rm --tag <yourname>/mariadb55 .

Check the image out.

    # docker images

Launching MariaDB
-----------------

### Quick start (not recommended for production use): ###

    # docker run --name=mariadb -d -p 3306:3306 -e MYSQL_ROOT_PASSWORD=<password> <yourname>/mariadb

### Recommended start ###

To use a separate data volume for /var/lib/mysql (recommended, to allow image update without
losing database contents):

Create a data volume container: (it doesn't matter what image you use
here, we'll never run this container again; it's just here to
reference the data volume)

    # docker run --name=mariadb-data -v /var/lib/mysql <yourname>/mariadb55 true

And now create the daemonized mariadb container:

    # docker run --name=mariadb -d -p 3306:3306 --volumes-from=mariadb-data -e MYSQL_ROOT_PASSWORD=<password> <yourname>/mariadb55

You could also create an additional database by passing MYSQL_DATABASE and/or create an additional user passing MYSQL_USER to the container.
You can specify database character set and/or collation by specifying MYSQL_CHARSET and/or MYSQL_COLLATION!

Using your MariaDB container
----------------------------

Keep in mind the initial password set for mariadb is: mysqlPassword.  Change it now:

    # mysqladmin --protocol=tcp -u testdb -p<password> password myNewPass

Connecting to mariadb:

    # mysql --protocol=tcp -utestdb -pmyNewPass

Create a sample table:

    \> CREATE TABLE test (name VARCHAR(10), owner VARCHAR(10),
        -> species VARCHAR(10), birth DATE, death DATE);
