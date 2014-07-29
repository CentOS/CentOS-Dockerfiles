dockerfiles-centos-httpd
========================

CentOS 6 dockerfile for httpd

Get Docker version

```
# docker version
```

To build:

Copy the sources down and do the build-

```
# docker build -rm -t <username>/httpd:centos6 .
```

To run (if port 80 is open on your host):

```
# docker run -d -p 80:80 <username>/httpd:centos6
```

or to assign a random port that maps to port 80 on the container:

```
# docker run -d -p 80 <username>/httpd:centos6
```

To the port that the container is listening on:

```
# docker ps
```

To test:

```
# curl http://localhost
```
