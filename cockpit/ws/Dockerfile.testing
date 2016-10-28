FROM centos
MAINTAINER "Mohammed Zeeshan Ahmed" <moahmed@redhat.com>

RUN yum -y update

RUN echo -e "[cockpit_test]\nname=Cockpit Test\nbaseurl=http://cbs.centos.org/repos/atomic7-cockpit-preview-testing/x86_64/os/\ngpgcheck=0\nenabled=1" > /etc/yum.repos.d/cockpit.repo

ENV INSTALL_PKGS "cockpit-ws"

# Get this specific version of cockpit-ws
RUN yum -y install ${INSTALL_PKGS} && yum clean all

# And the stuff that starts the container
RUN mkdir -p /container && ln -s /host/proc/1 /container/target-namespace
ADD atomic-install /container/atomic-install
ADD atomic-uninstall /container/atomic-uninstall
ADD atomic-run /container/atomic-run
RUN chmod -v +x /container/atomic-install
RUN chmod -v +x /container/atomic-uninstall
RUN chmod -v +x /container/atomic-run

# Make the container think it's the host OS version
RUN rm -f /etc/os-release /usr/lib/os-release && ln -sv /host/etc/os-release /etc/os-release && ln -sv /host/usr/lib/os-release /usr/lib/os-release

LABEL INSTALL /usr/bin/docker run -ti --rm --privileged -v /:/host IMAGE /container/atomic-install
LABEL UNINSTALL /usr/bin/docker run -ti --rm --privileged -v /:/host IMAGE /container/atomic-uninstall
LABEL RUN /usr/bin/docker run -d --privileged --pid=host -v /:/host IMAGE /container/atomic-run --local-ssh

# Look ma, no EXPOSE

CMD ["/container/atomic-run"]
