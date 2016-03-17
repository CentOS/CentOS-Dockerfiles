# This is ISC Bind9 container image dockerfile

FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

LABEL io.k8s.description="ISC BIND is open source software that implements the Domain Name System (DNS) protocols for the Internet" \
      io.k8s.display-name="ISC Bind 9" \
      io.openshift.expose-services="53:domain" \
      io.openshift.tags="dns,bind,named,bind9,named9"

LABEL Name="bind" \
      Version="9.9.4" \
      Architecture="x86_64"

# install main packages:
RUN yum -y install bind-utils bind && \
    yum clean all

ADD container-image-root /

# set up the BIND env and gen rndc key
RUN rndc-confgen -a -c /etc/rndc.key && \
    chown named:named /etc/rndc.key && \
    chmod 755 /entrypoint

EXPOSE 53/udp 53/tcp

VOLUME [ "/var/named/" ]

# start services:
ENTRYPOINT [ "/entrypoint"]
CMD [ "/usr/sbin/named" ]
