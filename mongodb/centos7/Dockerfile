# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM centos:centos7
LABEL maintainer="The CentOS Project <cloud-ops@centos.org>"

RUN yum update -y \
  && yum install -y \
  epel-release \
  mongodb-server \
  && yum clean all
  
RUN mkdir -p /data/db

EXPOSE 27017
ENTRYPOINT ["/usr/bin/mongod"]

