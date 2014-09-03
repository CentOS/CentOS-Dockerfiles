# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by 
#   "Maciej Lasyk" <maciek@lasyk.info>

FROM centos:centos6
MAINTAINER The CentOS Project <cloud-ops@centos.org>

# install main packages:
RUN yum -y update; yum clean all;
RUN yum -y install epel-release; yum clean all
RUN yum -y install bind-utils bind cronie logrotate supervisor openssh-server rsyslog sudo pwgen; yum clean all;

# gen rndc key:
RUN rndc-confgen -a -c /etc/rndc.key
RUN chown named:named /etc/rndc.key

# copy cfg files:
ADD ./cfg_files/rsyslogd.d/20-bind.conf /etc/rsyslogd.d/20-bind.conf
ADD ./cfg_files/logrotate.d/named /etc/logrotate.d/named
ADD ./cfg_files/logrotate.d/sshd /etc/logrotate.d/sshd
ADD ./cfg_files/init.d/named /etc/init.d/named
ADD ./cfg_files/init.d/sshd /etc/init.d/sshd
ADD ./cfg_files/named.conf /etc/named/named.conf
ADD ./cfg_files/cron.daily/update_named.ca.sh /etc/cron.daily/update_named.ca.sh
ADD ./cfg_files/supervisord.conf /etc/supervisord.conf
ADD ./cfg_files/supervisord.d/cron.ini /etc/supervisord.d/cron.ini
ADD ./cfg_files/supervisord.d/named.ini /etc/supervisord.d/named.ini
ADD ./cfg_files/supervisord.d/sshd.ini /etc/supervisord.d/sshd.ini
ADD ./cfg_files/supervisord.d/rsyslog.ini /etc/supervisord.d/rsyslog.ini
ADD ./cfg_files/sudoers.d/bindadm /etc/sudoers.d/bindadm
RUN mkdir /root/scripts -p
RUN chmod +x /etc/cron.daily/update_named.ca.sh
ADD ./cfg_files/root/scripts/init.sh /root/scripts/init.sh
RUN chmod +x /root/scripts/init.sh

# set up the BIND env:
RUN chmod +x /etc/init.d/{named,sshd}
RUN mkdir /var/dockerlock/subsys -p
RUN mkdir /var/log/named
RUN chown named:named /var/log/named

# set up the sshd env:
ADD ./cfg_files/bindadm/.ssh/authorized_keys /tmp/authorized_keys
RUN /root/scripts/init.sh

# and the supervisor env:
RUN mkdir -p /var/log/supervisor

EXPOSE 53

# start services:
CMD ["/usr/bin/supervisord"]
