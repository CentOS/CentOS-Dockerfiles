FROM centos:7

RUN yum -y update && yum clean all

RUN mkdir -p /go && chmod -R 777 /go && \
    yum install -y centos-release-scl && \
    yum -y install git go-toolset-7-golang && yum clean all

ENV GOPATH=/go \
    PATH=/opt/rh/go-toolset-7/root/usr/bin:/opt/rh/go-toolset-7/root/usr/sbin:$PATH

WORKDIR /go
