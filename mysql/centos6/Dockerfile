# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM centos:centos6
MAINTAINER The CentOS Project <cloud-ops@centos.org>


RUN yum update -y && yum clean all
RUN yum install mysql-server -y \
 && yum clean all

VOLUME /var/lib/mysql

COPY docker-entrypoint.sh /entrypoint.sh
RUN mkdir /docker-entrypoint-initdb.d \
 && chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/libexec/mysqld"]
