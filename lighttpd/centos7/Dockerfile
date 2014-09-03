# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   "Maciej Lasyk" <maciek@lasyk.info>

FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

# install main packages:
RUN yum -y update; yum clean all;
RUN yum -y install epel-release; yum clean all
RUN yum -y install openssh-server supervisor rsyslog sudo pwgen lighttpd; yum clean all;

# copy cfg files:
ADD ./cfg_files/supervisord.conf /etc/supervisord.conf
ADD ./cfg_files/logrotate.d/sshd /etc/logrotate.d/sshd
ADD ./cfg_files/logrotate.d/lighttpd /etc/logrotate.d/lighttpd
ADD ./cfg_files/init.d/sshd /etc/init.d/sshd
ADD ./cfg_files/init.d/lighttpd /etc/init.d/lighttpd
ADD ./cfg_files/supervisord.d/sshd.ini /etc/supervisord.d/sshd.ini
ADD ./cfg_files/supervisord.d/rsyslog.ini /etc/supervisord.d/rsyslog.ini
ADD ./cfg_files/supervisord.d/lighttpd.ini /etc/supervisord.d/lighttpd.ini
ADD ./cfg_files/sudoers.d/lighttpd /etc/sudoers.d/lighttpd

# set up env:
RUN chmod +x /etc/init.d/{sshd,lighttpd}
RUN mkdir /root/scripts -p
ADD ./cfg_files/root/scripts/init.sh /root/scripts/init.sh
RUN chmod +x /root/scripts/init.sh

# set up the sshd env:
ADD ./cfg_files/lighttpd/.ssh/authorized_keys /tmp/authorized_keys
RUN /root/scripts/init.sh

# and the supervisor env:
RUN mkdir -p /var/log/supervisor

EXPOSE 8091

# start services:
CMD ["/usr/bin/supervisord"]
