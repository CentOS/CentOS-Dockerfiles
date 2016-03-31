dockerfiles-centos-etherpad-mariadb
===================================

This dockerfile creates an etherpad image that is based on CentOS and
utilizes a centos/mariadb container for a database.

Build
-----

To build the etherpad container simply:

```
docker build -t <yourname>/etherpad .
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

Run etherpad
------------

Next start the etherpad with the db container linked:

```
docker run --link=mariadb:db -d --name etherpad -p 9001:9001 <yourname>/etherpad
```

Now connect to etherpad on localhost:9001 from your browser.


