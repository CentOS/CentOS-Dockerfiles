FROM centos:latest
MAINTAINER http://www.centos.org
LABEL Vendor="CentOS"
LABEL License=GPLv2
LABEL Version=2.4.6-31

RUN yum -y update && yum clean all
RUN yum -y install httpd && yum clean all

EXPOSE 80

# Simple startup script to avoid some issues observed with container restart 
COPY run-apache.sh /
RUN chmod -v +x /run-apache.sh

CMD ["/run-apache.sh"]
