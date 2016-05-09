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

ADD ./config_mysql.sh /config_mysql.sh

RUN chmod 755 /config_mysql.sh
RUN /config_mysql.sh

COPY docker-entrypoint.sh /entrypoint.sh
RUN mkdir /docker-entrypoint-initdb.d \
 && chmod +x /entrypoint.sh

EXPOSE 3306

ENTRYPOINT ["/entrypoint.sh"]

CMD ["mysqld_safe"]
