FROM centos
MAINTAINER Mohammed Zeeshan Ahmed <moahmed@redhat.com>
LABEL VERSION="0.9.5" ARCHITECTURE="amd64"
ARG plugins=git
RUN yum -y update && yum clean all
RUN yum -y install openssh-client git && yum clean all
RUN useradd -u 1001 -g 0 -d /srv caddy

RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/build?os=linux&arch=amd64&features=${plugins}" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
    && chmod 0755 /usr/bin/caddy \
    && /usr/bin/caddy -version

RUN mkdir -p /srv/config && mkdir -p /srv/public

ADD Caddyfile /srv/config/Caddyfile

RUN chown -R 1001:0 /srv && chmod -R 755 /srv

USER 1001

EXPOSE 80 443 2015 8080 8443

WORKDIR /srv/public

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/srv/config/Caddyfile"]