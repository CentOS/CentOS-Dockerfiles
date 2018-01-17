#  Official CentOS systemd docker container

The container was created as a base container for systemd based services. There is a sample containter that makes use of this image (https://github.com/xrowgmbh/docker-systemd-example-httpd).

## Sample httpd container

Here we show you how we can create a sample httpd container.

First create a Dockerfile and setup the required service or services. Systemd can launch multiple services.

```
FROM centos/systemd

MAINTAINER "Your Name" <you@example.com>

RUN yum -y install httpd; yum clean all; systemctl enable httpd.service

EXPOSE 80

CMD ["/usr/sbin/init"]
```

Then build it.

```
docker build --rm --no-cache -t httpd .
```

Launch it.

```
docker run --privileged --name httpd -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 80:80 -d  httpd
```

Finally use it.
