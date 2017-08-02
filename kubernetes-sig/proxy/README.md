dockerfiles-fedora-kubernetes-proxy
===================================

Fedora dockerfile for kube-proxy.  Tested with Docker 1.7.1.

Get Docker version
```
# docker version
```

To build:

Build or pull the `fedora/kubernetes-node` container.

Copy the source Dockerfile down and do the build:
```
# docker build --rm -t <username>/kubernetes-proxy .
```

To run (use `--opt1` to pass options to Docker, and `--opt3` to pass options to proxy):

```
# atomic run --opt3="--master=http://$MASTER_IP:8080" fedora/kubernetes-proxy
```

Refer to the Kubernetes documentation for more information about applicable options.
Options will be pulled the command line, as well as from `/etc/kubernetes/{config,proxy}`,
so you can mount an existing `/etc/kubernetes` folder into the container to reuse existing
configuration.
