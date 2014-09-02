# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   Stephen Tweedie <sct@redhat.com>

FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN yum update -y; yum clean all
RUN yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-1.noarch.rpm; yum clean all
RUN yum install -y docker-registry; yum clean all
ADD run-registry.sh /opt/registry/run-registry.sh
RUN chmod -v 755 /opt/registry/run-registry.sh
CMD ["/opt/registry/run-registry.sh"]
EXPOSE 5000

