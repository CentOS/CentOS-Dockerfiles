FROM registry.centos.org/centos/centos:7

MAINTAINER Mohammed Zeeshan Ahmed <moahmed@redhat.com>

# RUN yum -y update && yum clean all

RUN mkdir -p /opt/scripts /opt/data mkdir -p /var/www/reviewboard && touch /opt/data/database.sqllite3 && touch /opt/data/cachefile

WORKDIR /var/www/reviewboard

ADD install.sh fix-permissions.sh run.sh passwd.template /opt/scripts/

RUN . /opt/scripts/install.sh

EXPOSE 8080 8443

USER apache

ENTRYPOINT ["/opt/scripts/run.sh"]
CMD ["review"]
