FROM registry.centos.org/centos/centos:7

MAINTAINER Mohammed Zeeshan Ahmed <moahmed@redhat.com>

RUN yum -y update && yum clean all

RUN mkdir -p /srv/git /opt/scripts

ADD ./fix-permissions.sh ./install.sh ./passwd.template ./run.sh /opt/scripts/

RUN chmod -R 777 /opt/scripts && . /opt/scripts/install.sh

WORKDIR /srv/git

EXPOSE 8080 8443

USER apache

ENTRYPOINT ["/opt/scripts/run.sh"]
CMD ["cgit"]
