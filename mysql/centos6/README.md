dockerfiles-centos-MySQL
========================

This repo contains a recipe for making Docker container for SSH and MySQL on CentOS 6. 

Check your Docker version

    # docker version

Perform the build

    # docker build -rm -t <yourname>/mysql:centos6 .

Check the image out.

    # docker images

Run it:

    # docker run -d -p 3306:3306 <yourname>/mysql:centos6

Get container ID:

    # docker ps

Keep in mind the password set for MySQL is: mysqlPassword

Get the IP address for the container:

    # docker inspect <container_id> | grep -i ipaddr

For MySQL:
    # mysql -h 172.17.0.x -utestdb -pmysqlPassword


Create a table:

```
\> CREATE TABLE test (name VARCHAR(10), owner VARCHAR(10),
    -> species VARCHAR(10), birth DATE, death DATE);
```
