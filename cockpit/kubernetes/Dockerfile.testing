FROM centos

RUN yum update -y && yum clean all
ADD . /container
RUN echo -e "[cockpit_test]\nname=Cockpit Test\nbaseurl=http://cbs.centos.org/repos/atomic7-cockpit-preview-testing/x86_64/os/\ngpgcheck=0\nenabled=1" > /etc/yum.repos.d/cockpit.repo

RUN /container/install.sh

CMD ["/usr/libexec/cockpit-kube-launch"]
