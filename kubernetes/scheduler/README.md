dockerfiles-fedora-kubernetes-scheduler
=======================================

Fedora dockerfile for kube-scheduler.  Tested with Docker 1.7.1.

Get Docker version
```
# docker version
```

To build:

Build or pull the `fedora/kubernetes-master` container.

Copy the source Dockerfile down and do the build:
```
# docker build --rm -t <username>/kubernetes-scheduler .
```

To run:

```
# docker run -d --net=host <username>/kube-scheduler $KUBE_SCHEDULER_OPTIONS
```

Refer to the Kubernetes documentation for more information about applicable options.
