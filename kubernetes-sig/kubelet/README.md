dockerfiles-fedora-kubernetes-kubelet
=====================================

Fedora dockerfile for kubelet.  Tested with Docker 1.7.1.

Get Docker version
```
# docker version
```

To build:

Build or pull the `fedora/kubernetes-node` container.

Copy the source Dockerfile down and do the build:
```
# docker build --rm -t <username>/kubernetes-kubelet .
```

To run (use `--opt1` to pass options to Docker, and `--opt3` to pass options to kubelet):

```
# atomic run --opt1="-v /etc/kubernetes/manifests:/etc/kubernetes/manifests:ro" --opt3="--address=$MASTER_IP --config=/etc/kubernetes/manifests --hostname_override=$MASTER_IP --api_servers=http://$MASTER_IP:8080" fedora/kubernetes-kubelet
```

Refer to the Kubernetes documentation for more information about applicable options.
Options will be pulled the command line, as well as from `/etc/kubernetes/{config,kubelet}`,
so you can mount an existing `/etc/kubernetes` folder into the container to reuse existing
configuration.
