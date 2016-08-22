FROM centos:latest
MAINTAINER http://www.centos.org

ENV ZNC_VERSION=1.6.3 \
    DATADIR=/var/lib/znc-data

LABEL summary="ZNC is an IRC bouncer" \
      io.k8s.description="ZNC is an IRC bouncer" \
      io.k8s.display-name="ZNC 1.6.3" \
      io.openshift.expose-services="6667:znc" \
      io.openshift.tags="znc,ircbouncer" \
      Vendor="CentOS" \
      License=GPLv2 \
      Version=1.6.3


EXPOSE 6667

RUN INSTALL_PKGS="rsync tar gettext hostname bind-utils policycoreutils znc znc-devel" && \
    yum -y install epel-release && \
    yum install -y --setopt=tsflags=nodocs $INSTALL_PKGS && \
    rpm -V $INSTALL_PKGS && \
    yum clean all && \
    mkdir -p /var/lib/znc-data && chown -R znc.0 /var/lib/znc-data && \
    rpm -q --qf '%{version}' znc | grep -e '1\.6\.3' && \
    test "$(id znc)" = "uid=997(znc) gid=996(znc) groups=996(znc)"

ENV CONTAINER_SCRIPTS_PATH=/usr/share/container-scripts/znc

ADD root /

VOLUME ["/var/lib/znc-data"]

USER 997
ENTRYPOINT ["container-entrypoint"]
CMD ["run-znc"]
