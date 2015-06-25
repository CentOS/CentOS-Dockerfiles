dockerfiles-fedora-kube-controller-manager
==========================================

Fedora dockerfile for kube-controller-manager.  Tested with Docker 1.7.1.

Get Docker version
```
# docker version
```

To build:

Build or pull the `fedora/kubernetes-master` container.

Copy the source Dockerfile down and do the build:
```
# docker build --rm -t <username>/kubernetes-controller-manager .
```

To run:

```
# docker run -d --net=host --privileged <username>/kube-controller-manager $KUBE_CONTROLLER_MGR_OPTIONS
```

Refer to the Kubernetes documentation for more information about applicable options.
