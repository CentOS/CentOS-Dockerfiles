FROM registry.centos.org/centos/centos:7

MAINTAINER Mohammed Zeesahan Ahmed <moahmed@redhat.com>

# RUN yum -y update && yum clean all

ADD install.sh run.sh fix-permissions.sh passwd.template /opt/scripts/

RUN chmod -R 777 /opt/scripts && . /opt/scripts/install.sh

EXPOSE 8080 8443

USER apache

WORKDIR /usr/share/phpPgAdmin

ENTRYPOINT ["/opt/scripts/run.sh"]

CMD ["phppgadmin"]
