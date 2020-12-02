# "ported" by Domingo Ruiz <ordenadordomi@gmail.com> from
#   https://github.com/CentOS/CentOS-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   "Maciej Lasyk" <maciek@lasyk.info>

FROM centos:centos8
MAINTAINER Domingo Ruiz Arroyo <ordenadordomi@gmail.com>

# install main packages:
RUN yum -y update;
RUN yum -y install epel-release;
RUN yum -y install openssh-server supervisor rsyslog sudo pwgen lighttpd;

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
