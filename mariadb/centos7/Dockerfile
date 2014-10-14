FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN yum -y update && yum clean all
RUN yum -y install epel-release && yum clean all
RUN yum -y install mariadb-server bind-utils pwgen supervisor psmisc \
    net-tools hostname && yum clean all

ADD ./start.sh /start.sh
ADD ./config_mariadb.sh /config_mariadb.sh
ADD ./supervisord.conf /etc/supervisord.conf

RUN chmod 755 /start.sh
RUN chmod 755 /config_mariadb.sh
RUN /config_mariadb.sh

EXPOSE 3306

CMD ["/bin/bash", "/start.sh"]
