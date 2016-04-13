# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   Aditya Patawari <adimania@fedoraproject.org>
# and incorporating work from kubernetes

FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

LABEL io.k8s.description="Redis is an open source, in-memory data structure store, used as database, cache and message broker." \
      io.k8s.display-name="Redis 2.8.19-2.el7" \
      io.openshift.expose-services="6379:redis" \
      io.openshift.tags="database,redis,redis3"

LABEL Name="centos/redis-28-centos7" \
      Version="2.8.19" \
      Release="2" \
      Architecture="x86_64"

RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y --setopt=tsflags=nodocs install epel-release && \
    yum -y --setopt=tsflags=nodocs install redis && \
    yum clean all

COPY redis-master.conf /redis-master/redis.conf
COPY redis-slave.conf /redis-slave/redis.conf
COPY entrypoint /entrypoint
RUN mkdir /redis-master-data && \
    chmod 755 /entrypoint /redis-master-data && \
    chown 997 /redis-master-data

EXPOSE 6379

# By default will run as random user on openshift and the redis user (997)
# everywhere else
USER 997

CMD [ "/entrypoint" ]
ENTRYPOINT [ "sh", "-c" ]
