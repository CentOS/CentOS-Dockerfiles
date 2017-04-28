FROM centos:7

RUN yum -y update

ENV GOLANG_VERSION 1.8.1
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

ADD https://storage.googleapis.com/golang/go$GOLANG_VERSION.linux-amd64.tar.gz /tmp

RUN yum -y install git
RUN cd /tmp \
    && tar -C /usr/local/ -xvzf go$GOLANG_VERSION.linux-amd64.tar.gz \
    && mkdir -p "$GOPATH/src" "$GOPATH/bin" \
    && chmod -R 777 "$GOPATH"
RUN cd /tmp && rm go*

LABEL   br.com.egoncalves="Eduardo Gonçalves" \
        version="1.0" \
        description="Golang 1.8.1 running on CentOs7"
