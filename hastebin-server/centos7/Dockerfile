FROM registry.centos.org/centos/centos:7

MAINTAINER Mohammed Zeeshan Ahmed <moahmed@redhat.com>

# RUN yum -y update && yum clean all

ENV PATH=/opt/nodejs/bin:$PATH

RUN mkdir -p /opt/scripts /opt/hastebin-server /opt/data /opt/nodejs

ADD install.sh run.sh config.js.template fix-permissions.sh /opt/scripts/

RUN chmod -R 777 /opt/scripts && . /opt/scripts/install.sh

WORKDIR /opt/hastebin-server

EXPOSE 7777

ENTRYPOINT ["/opt/scripts/run.sh"]

CMD ["hastebin"]

USER 1001
