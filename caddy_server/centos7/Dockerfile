FROM centos:7
LABEL maintainer="Mohammed Zeeshan Ahmed <moahmed@redhat.com>"
LABEL VERSION="0.10.10" ARCHITECTURE="amd64"
RUN yum -y update && yum clean all
ARG plugins=dns,dyndns,hook.service,http.authz,http.awses,http.awslambda,http.cache,http.cgi,http.cors,http.datadog,http.expires,http.filemanager,http.filter,http.forwardproxy,http.git,http.gopkg,http.grpc,http.hugo,http.ipfilter,http.jekyll,http.jwt,http.locale,http.login,http.mailout,http.minify,http.nobots,http.prometheus,http.proxyprotocol,http.ratelimit,http.realip,http.reauth,http.restic,http.upload,http.webdav,net
RUN yum -y install openssh-client git && yum clean all
RUN mkdir -p /etc/caddy && useradd -u 1001 -g 0 caddy
RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/linux/amd64?license=personal&plugins=${plugins}" \
    | tar --no-same-owner -C /usr/bin/ -xz caddy \
    && chmod 0755 /usr/bin/caddy \
    && /usr/bin/caddy -version

RUN mkdir -p /var/www/html && chown -R 1001:0 /var/www && chmod -R 777 /var/www && chmod -R g+s /var/www

ADD Caddyfile /etc/caddy/Caddyfile

RUN chown -R 1001:0 /etc/caddy && chmod -R 775 /etc/caddy

USER 1001

EXPOSE 80 443 2015 8080 8443

WORKDIR /var/www/html

ENTRYPOINT ["/usr/bin/caddy"]
CMD ["-quic" ,"--conf", "/etc/caddy/Caddyfile"]
