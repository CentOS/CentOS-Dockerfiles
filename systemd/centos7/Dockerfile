FROM centos:7

ENV container docker
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;

# Systemd defines that it expects SIGRTMIN+3 for graceful shutdown
# https://www.commandlinux.com/man-page/man1/systemd.1.html#lbAH
STOPSIGNAL SIGRTMIN+3

VOLUME [ "/sys/fs/cgroup" ]

CMD ["/usr/sbin/init"]
