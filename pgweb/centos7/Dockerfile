FROM centos:7
MAINTAINER Mohammed Zeeshan Ahmed <moahmed@redhat.com>

ENV PGWEB_VERSION "0.9.6"

RUN yum -y update && yum clean all

RUN  yum -y install unzip && \
     curl -L https://github.com/sosedoff/pgweb/releases/download/v${PGWEB_VERSION}/pgweb_linux_amd64.zip > /tmp/pgweb.zip && \
     unzip /tmp/pgweb.zip -d /app && yum -y remove unzip && yum clean all && rm -rf /tmp/pgweb.zip

RUN useradd pgweb -u 1001 -g 0 -d /app && chown -R 1001:0 /app && chmod -R ug+rwx /app

USER 1001
WORKDIR /app

EXPOSE 8080
ENTRYPOINT ["/app/pgweb_linux_amd64"]
CMD ["-s", "--bind=0.0.0.0", "--listen=8080"]
