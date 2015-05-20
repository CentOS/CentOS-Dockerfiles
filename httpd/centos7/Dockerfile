FROM centos:latest
MAINTAINER http://www.centos.org

RUN yum -y update && yum clean all
RUN yum -y install httpd && yum clean all

EXPOSE 80

# Simple startup script to avoid some issues observed with container restart 
ADD run-apache.sh /run-apache.sh
RUN chmod -v +x /run-apache.sh

CMD ["/run-apache.sh"]
