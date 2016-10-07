# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>

FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN yum -y update &&\
    yum clean all

RUN yum -y install httpd php php-mysql php-gd openssl psmisc tar &&\
    yum clean all

ADD scripts /scripts
RUN curl -LO http://wordpress.org/latest.tar.gz                         &&\
    tar xvzf /latest.tar.gz -C /var/www/html --strip-components=1       &&\
    rm /latest.tar.gz                                                   &&\
    chown -R apache:apache /var/www/                                    &&\
    chmod 755 /scripts/*

EXPOSE 80
CMD ["/bin/bash", "/scripts/start.sh"]
