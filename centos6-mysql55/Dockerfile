FROM centos:centos6

MAINTAINER Manuel Vacelet <manuel.vacelet@enalean.com>

RUN yum -y update && yum clean all
RUN yum -y install scl-utils && yum clean all

RUN yum install -y centos-release-SCL && yum clean all

RUN yum install -y --enablerepo=centosplus mysql55-mysql-server && yum clean all

VOLUME /var/lib/mysql

ADD my.cnf /opt/rh/mysql55/root/etc/my.cnf
ADD docker-entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

EXPOSE 3306

CMD ["/entrypoint.sh"]
