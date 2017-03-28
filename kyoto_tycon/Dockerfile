FROM registry.centos.org/centos/centos:latest

RUN yum -y update && yum clean all

WORKDIR /usr/local/src/kyoto

RUN mkdir -p /opt/scripts /var/ktserver

ADD ./install.sh ./fix-permissions.sh /opt/scripts/

RUN . /opt/scripts/install.sh

RUN ldconfig

EXPOSE 1978 11401

USER 1001

CMD /etc/rc.d/init.d/ktserver start && tail -F /var/ktserver/log
