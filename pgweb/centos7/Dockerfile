FROM centos:7
MAINTAINER Mohammed Zeeshan Ahmed <moahmed@redhat.com>

RUN yum -y update && yum clean all

COPY ./install-pgweb.py ./install-pgweb.py

RUN python ./install-pgweb.py && rm -rf ./*.py*

USER pgweb
WORKDIR /app

EXPOSE 8080
ENTRYPOINT ["/app/pgweb_linux_amd64"]
CMD ["-s", "--bind=0.0.0.0", "--listen=8080"]
