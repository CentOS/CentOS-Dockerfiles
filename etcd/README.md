# etcd-container

Building etcd container for rhel, centos and atomic host:

```
# git clone https://github.com/aveshagarwal/etcd-container
# cd etcd-container
# docker build --rm -t etcd .
```
**Instructions for RHEL and CentOS**

Running etcd container

```
#docker run -d -p 4001:4001 -p 7001:7001 -p 2379:2379 -p 2380:2380 etcd
```

**Instructions for Atomic**

Installing etcd container on atomic host:

```
#atomic install etcd
```

Running etcd container on atomic host:

```
#atomic run etcd
```

Stopping etcd container on atomic host:

```
#atomic stop etcd
```

Uninstalling etcd container on atomic host:

```
#atomic uninstall etcd
```
