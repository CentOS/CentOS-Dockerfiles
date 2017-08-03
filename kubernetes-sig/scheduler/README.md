dockerfiles-centos-kubernetes-scheduler
=======================================

CentOS dockerfile for kube-scheduler.  Tested with docker-1.10.3-59.el7.centos.x86_64

Get Docker version
```
# docker version
```

To build:

Build or pull the `centos/kubernetes-master` container.

Copy the source Dockerfile down and do the build:
```
# docker build --rm -t <username>/kubernetes-scheduler .
```

To run:

```
# docker run -d --net=host <username>/kube-scheduler $KUBE_SCHEDULER_OPTIONS
```

Refer to the Kubernetes documentation for more information about applicable options.
Options will be pulled the command line, as well as from `/etc/kubernetes/{config,scheduler}`,
so you can mount an existing `/etc/kubernetes` folder into the container to reuse existing
configuration.
