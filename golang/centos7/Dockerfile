FROM centos:7

RUN yum -y update && yum clean all
RUN mkdir /opt/scripts

ADD ./install.sh /opt/scripts/

RUN chmod -R +x /opt/scripts && /opt/scripts/install.sh

ENV GOPATH /go


