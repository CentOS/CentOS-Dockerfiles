# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN  yum -y update && yum clean all

COPY ./install.sh /tmp/install.sh

RUN /bin/sh /tmp/install.sh

RUN rm -rf /tmp/install.sh

EXPOSE  5984

CMD ["/bin/bash", "-e", "/usr/local/bin/couchdb", "start"]
