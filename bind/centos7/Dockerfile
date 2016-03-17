# This is ISC Bind9 container image dockerfile
# it is IPv4 only

FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

# Labels consumed by OpenShift
LABEL io.k8s.description="ISC BIND is open source software that implements the Domain Name System (DNS) protocols for the Internet" \
      io.k8s.display-name="ISC Bind 9" \
      io.openshift.expose-services="53:domain" \
      io.openshift.tags="dns,bind,named,bind9,named9"

# Labels consumed by Nulecule Specification
# Environment:
#  * $EXTRA_ARGS     - extra arguments to /usr/sbin/named, used by the entrypoint
LABEL io.projectatomic.nulecule.environment.optional="EXTRA_ARGS"

# Labels consumed by Red Hat build service
LABEL Name="bind" \
      Version="9.9.4" \
      Architecture="x86_64" \
      vcs-type="git" \
      vcs-url="https://github.com/CentOS/CentOS-Dockerfiles/tree/master/bind/centos7" \
      distribution-scope="public"

# install main packages:
RUN yum -y install bind-utils bind && \
    yum clean all

ADD container-image-root /

# set up the BIND env and gen rndc key
RUN rndc-confgen -a -c /etc/rndc.key && \
    chown named:named /etc/rndc.key && \
    chmod 755 /entrypoint

EXPOSE 53/udp 53/tcp

# Labels consumed by Nulecule Specification
# Volumes:
#  * /named   - this is where all the named data lives
LABEL io.projectatomic.nulecule.volume.data="/named,128Mi"
VOLUME [ "/named" ]

# start services:
ENTRYPOINT [ "/entrypoint"]
CMD [ "/usr/sbin/named" ]
