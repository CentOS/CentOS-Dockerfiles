# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   scollier <scollier@redhat.com>
FROM centos:centos7
ENV PG11=https://download.postgresql.org/pub/repos/yum/11/redhat/rhel-7-x86_64/pgdg-centos11-11-2.noarch.rpm 
ENV PG9=https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-3.noarch.rpm
ENV PGPATH=/usr/pgsql-9.5

#
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN yum -y update \
	&& yum clean all \
	&& yum -y install ${PG9} postgresql95 postgresql95-server postgresql95-contrib rsync \
#RUN yum -y install sudo epel-release; yum clean all
#RUN yum -y install postgresql-server postgresql postgresql-contrib supervisor pwgen; yum clean all

ADD ./postgresql-setup ${PGPATH}/bin/postgresql-setup
ADD ./supervisord.conf /etc/supervisord.conf
ADD ./start_postgres.sh /start_postgres.sh

#Sudo requires a tty. fix that.
RUN sed -i 's/.*requiretty$/#Defaults requiretty/' /etc/sudoers
RUN chmod +x ${PGPATH}/bin/postgresql-setup
RUN chmod +x /start_postgres.sh

RUN ${PGPATH}/bin/postgresql-setup initdb

ADD ./postgresql.conf /var/lib/pgsql/data/postgresql.conf

RUN chown -v postgres.postgres /var/lib/pgsql/9.5/data/postgresql.conf

RUN echo "host    all             all             0.0.0.0/0               md5" >> /var/lib/pgsql/data/pg_hba.conf

VOLUME ["/var/lib/pgsql"]

EXPOSE 5432

CMD ["/bin/bash", "/start_postgres.sh"]
