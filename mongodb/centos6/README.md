dockerfiles-centos-mongodb
========================

CentOS 6 dockerfile for MongoDB

Get the version of Docker

    # docker version

To build:

Copy the sources down -

    # docker build -rm -t <username>/mongo:centos6 .

To run:

    # docker run -d -p 27017 <username>/mongo:centos6

Watch for the database to initialize and start listening (using the container ID from "docker run":

```
# docker logs 3a2aaa5b803f597732b18
<snip>
Tue Dec 17 20:34:42.655 [initandlisten] command local.$cmd command: { create: "startup_log", size: 10485760, capped: true } ntoreturn:1 keyUpdates:0  reslen:37 360ms
Tue Dec 17 20:34:42.661 [websvr] admin web console waiting for connections on port 28017
Tue Dec 17 20:34:42.725 [initandlisten] waiting for connections on port 27017
```

Get the port that the container is listening on:

```
# docker ps
CONTAINER ID        IMAGE                   COMMAND             CREATED             STATUS              PORTS                      NAMES
c8fc42d19fd3        <username>/mongo:centos6   /usr/bin/mongod     4 minutes ago       Up 4 minutes        0.0.0.0:49158->27017/tcp   ecstatic_thompson   
```

To test:

```
# mongo --host localhost --port 49158

MongoDB shell version: 2.4.6
connecting to: 127.0.0.1:49158/test
> 
```


