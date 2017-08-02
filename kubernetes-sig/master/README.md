dockerfiles-centos-kubernetes-master
====================================

Base centos dockerfile for the kubernetes master services.
Tested with docker-1.10.3-59.el7.centos.x86_64

Get Docker version
```
# docker version
```

To build:

Copy the source Dockerfile down and do the build:
```
# docker build --rm -t centos/kubernetes-master .
```
