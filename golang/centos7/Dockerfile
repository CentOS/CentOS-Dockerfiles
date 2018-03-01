FROM centos:7

ENV GOPATH /go

RUN yum -y update && \
    mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH" && \
    yum -y install git golang && yum clean all

ENV PATH $PATH:$GOPATH/bin

WORKDIR $GOPATH
