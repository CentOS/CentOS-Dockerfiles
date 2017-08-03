dockerfiles-fedora-kubernetes-node
==================================

Base fedora dockerfile for the kubernetes node services.
Tested with Docker 1.7.1.

Get Docker version
```
# docker version
```

To build:

Copy the source Dockerfile down and do the build:
```
# docker build --rm -t fedora/kubernetes-node .
```
