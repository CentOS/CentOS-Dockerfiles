FROM centos:7
MAINTAINER Mohammed Zeeshan Ahmed <moahmed@redhat.com>
LABEL VERSION="0.9.5" ARCHITECTURE="amd64"
RUN yum -y update && yum clean all
ARG plugins=DNS%2Cawslambda%2Ccors%2Cexpires%2Cfilemanager%2Cgit%2Chugo%2Cipfilter%2Cjsonp%2Cjwt%2Clocale%2Cmailout%2Cminify%2Cmultipass%2Cprometheus%2Cratelimit%2Crealip%2Csearch%2Cupload%2Ccloudflare%2Cdigitalocean%2Cdnsimple%2Cdyn%2Cgandi%2Cgooglecloud%2Clinode%2Cnamecheap%2Crfc2136%2Croute53%2Cvultr
RUN yum -y install openssh-client git && yum clean all
RUN mkdir -p /etc/caddy && useradd -u 1001 -g 0 caddy
RUN curl --silent --show-error --fail --location \
      --header "Accept: application/tar+gzip, application/x-gzip, application/octet-stream" -o - \
      "https://caddyserver.com/download/build?os=linux&arch=amd64&features=${plugins}" \
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
