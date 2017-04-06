FROM registry.centos.org/centos/centos:7

MAINTAINER Mohammed Zeeshan Ahmed <moahmed@redhat.com>

# RUN yum -y update && yum clean all

ENV MOODLE_VERSION="3.1" \
    MOODLE_NODOT_VERSION="stable31"\
    PHP_REMI_VERSION="php71"

RUN mkdir -p /opt/scripts

ADD install.sh fix-permissions.sh run.sh passwd.template /opt/scripts/

RUN . /opt/scripts/install.sh

EXPOSE 8080 8443

WORKDIR /var/www/html

USER apache

ENTRYPOINT ["/opt/scripts/run.sh"]
CMD ["moodle"]