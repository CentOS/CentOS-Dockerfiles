dockerfiles-centos-kube-controller-manager
==========================================

CentOS dockerfile for kube-controller-manager.  Tested with docker-1.10.3-59.el7.centos.x86_64.

Get Docker version
```
# docker version
```

To build:

Build or pull the `centos/kubernetes-master` container.

Copy the source Dockerfile down and do the build:
```
# docker build --rm -t <username>/kubernetes-controller-manager .
```

To run:

```
# docker run -d --net=host --privileged <username>/kube-controller-manager $KUBE_CONTROLLER_MGR_OPTIONS
```

Refer to the Kubernetes documentation for more information about applicable options.
Options will be pulled the command line, as well as from `/etc/kubernetes/{config,controller-manager}`,
so you can mount an existing `/etc/kubernetes` folder into the container to reuse existing
configuration.
