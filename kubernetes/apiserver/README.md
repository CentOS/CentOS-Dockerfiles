dockerfiles-fedora-kubernetes-apiserver
=======================================

Fedora dockerfile for kube-apiserver.  Tested with Docker 1.7.1.

Get Docker version
```
# docker version
```

To build:

Build or pull the `fedora/kubernetes-master` container.

Copy the source Dockerfile down and do the build:
```
# docker build --rm -t <username>/kubernetes-apiserver .
```

To run:

```
# docker run -d --net=host <username>/kube-apiserver $KUBE_APISERVER_OPTIONS
```

Refer to the Kubernetes documentation for more information about applicable options.
Options will be pulled the command line, as well as from `/etc/kubernetes/{config,apiserver}`,
so you can mount an existing `/etc/kubernetes` folder into the container to reuse existing
configuration.
