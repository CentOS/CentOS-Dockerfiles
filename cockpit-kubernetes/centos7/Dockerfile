FROM centos:7

ARG RELEASE=1
ARG VERSION=0.103
ARG OFFLINE

ADD . /container
RUN /container/install.sh

CMD ["/usr/libexec/cockpit-kube-launch"]
