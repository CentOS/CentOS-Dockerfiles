FROM centos:7

ARG RELEASE=1
ARG VERSION=0.104
ARG OFFLINE

ADD . /container
RUN /container/install.sh

CMD ["/usr/libexec/cockpit-kube-launch"]
