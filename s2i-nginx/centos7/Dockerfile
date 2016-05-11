FROM centos:centos7

MAINTAINER The CentOS Project <cloud-ops@centos.org>
# based on work of Tobias Florek <tob@butter.sh>

ENV NGINX_VERSION="1.8" \
    NGINX_BASE_DIR="/opt/rh/rh-nginx18/root" \
    NGINX_VAR_DIR="/var/opt/rh/rh-nginx18" \
    STI_SCRIPTS_PATH="/usr/libexec/s2i"

LABEL io.k8s.description="Platform for running nginx or building nginx-based application" \
      io.k8s.display-name="Nginx 1.8 builder" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,nginx,nginx18" \
      Name="centos/s2i-nginx" \
      Version="1.8" \
      Release="1" \
      Architecture="x86_64"

RUN yum install --setopt=tsflags=nodocs -y centos-release-scl-rh && \
    yum install --setopt=tsflags=nodocs -y bcrypt rh-nginx${NGINX_VERSION/\./} && \
    yum clean all -y && \
    mkdir -p /opt/app-root/etc/nginx.conf.d /opt/app-root/run && \
    chmod -R a+rx  $NGINX_VAR_DIR/lib/nginx && \
    chmod -R a+rwX $NGINX_VAR_DIR/lib/nginx/tmp \
                   $NGINX_VAR_DIR/log \
                   $NGINX_VAR_DIR/run \
                   /opt/app-root/run

COPY ./etc/ /opt/app-root/etc
COPY ./.s2i/bin/ ${STI_SCRIPTS_PATH}

RUN cp /opt/app-root/etc/nginx.server.sample.conf /opt/app-root/etc/nginx.conf.d/default.conf && \
    chown -R 1001:1001 /opt/app-root

USER 1001

EXPOSE 8080

CMD ["usage"]
