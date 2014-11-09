A container for mysql55 on centos6
==================================

Create a data volume to make your write persistent
   $> docker run --name=dbdata -v /var/lib/mysql centos true

Note: you should never delete this container otherwise your data will be gone.

Initialize a new DB:

    $> docker run --rm=true -e MYSQL_ROOT_PASSWORD=welcome0 --volumes-from=dbdata centos/centos6-mysql55

Run the DB:

    $> docker run -d --volumes-from=dbdata centos/centos6-mysql55

Connect:

    $> mysql -h X.X.X.X -uroot -pwelcome0

Environment
===========

* Port exposed: 3306
* Volume: /var/lib/mysql
* Variable: MYSQL_ROOT_PASSWORD (at init time only)

Build the image
===============

    $> docker build --rm=true -t centos/centos6-mysql55 centos6-mysql55

Credits
=======

Strongly inspired from https://github.com/docker-library/docker-mysql
