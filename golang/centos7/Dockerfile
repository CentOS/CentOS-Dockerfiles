FROM centos:7

RUN yum -y update && yum clean all

RUN mkdir -p /go && chmod -R 777 /go && \
    yum -y install git golang && yum clean all

ENV GOPATH /go

WORKDIR /go
