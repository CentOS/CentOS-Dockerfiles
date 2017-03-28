FROM registry.centos.org/centos/centos:latest

WORKDIR /usr/local/src

# RUN yum -y update && yum clean all

RUN mkdir -p /opt/scripts

ADD ./install.sh /opt/scripts/

RUN . /opt/scripts/install.sh

RUN ldconfig

EXPOSE 1978 11401

CMD /etc/rc.d/init.d/ktserver start && tail -F /var/ktserver/log
