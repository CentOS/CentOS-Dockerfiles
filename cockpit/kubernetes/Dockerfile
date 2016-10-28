FROM centos

RUN yum update -y && yum clean all
ADD . /container
RUN /container/install.sh

CMD ["/usr/libexec/cockpit-kube-launch"]
