FROM centos/centos:7
MAINTAINER Mohammed Zeeshan Ahmed <moahmed@redhat.com>
LABEL VERSION="0.9.5" ARCHITECTURE="amd64"
ARG plugins=git
RUN yum -y update && yum clean all
RUN yum -y install openssh-client git && yum clean all
RUN mkdir -p /etc/caddy /var/www/html && useradd -u 1001 -g 0 -d /var/www caddy

RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/build?os=linux&arch=amd64&features=${plugins}" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
    && chmod 0755 /usr/bin/caddy \
    && /usr/bin/caddy -version

ADD Caddyfile /etc/caddy/Caddyfile

RUN chown -R 1001:0 /etc/caddy && chmod -R 755 /etc/caddy && chown -R 1001:0 /var/www/html && chmod -R 775 /var/www/html

USER 1001

EXPOSE 80 443 2015 8080 8443

WORKDIR /var/www/html

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["--conf", "/etc/caddy/Caddyfile"]
