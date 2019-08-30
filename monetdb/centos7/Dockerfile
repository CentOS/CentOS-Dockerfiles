FROM registry.centos.org/centos/centos:7

MAINTAINER Mohammed Zeeshan Ahmed <moahmed@redhat.com>

#RUN yum -y update && yum clean all

RUN mkdir -p /opt/scripts

ADD install.sh fix-permissions.sh run.sh passwd.template supervisord.conf.template /opt/scripts/

RUN . /opt/scripts/install.sh

USER monetdb

EXPOSE 50000

WORKDIR /var/monetdbdata

ENTRYPOINT ["/opt/scripts/run.sh"]
CMD ["monetdb"]