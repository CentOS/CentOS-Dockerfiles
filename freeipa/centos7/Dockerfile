# Clone from the CentOS 7
FROM centos:centos7

MAINTAINER Jan Pazdziora

RUN yum swap -y -- remove fakesystemd -- install systemd systemd-libs && yum clean all
RUN yum -y update && yum clean all

RUN curl -o /etc/yum.repos.d/mkosek-freeipa-epel-7.repo https://copr.fedorainfracloud.org/coprs/mkosek/freeipa/repo/epel-7/mkosek-freeipa-epel-7.repo

# Install FreeIPA server
RUN mkdir -p /run/lock ; yum install -y freeipa-server ipa-server-dns bind bind-dyndb-ldap perl && yum clean all

ADD dbus.service /etc/systemd/system/dbus.service
RUN ln -sf dbus.service /etc/systemd/system/messagebus.service

ADD runuser-pp /usr/sbin/runuser-pp
ADD systemctl /usr/bin/systemctl
ADD systemctl-socket-daemon /usr/bin/systemctl-socket-daemon

ADD ipa-server-configure-first /usr/sbin/ipa-server-configure-first

RUN chmod -v +x /usr/bin/systemctl /usr/bin/systemctl-socket-daemon /usr/sbin/ipa-server-configure-first /usr/sbin/runuser-pp

EXPOSE 53/udp 53 80 443 389 636 88 464 88/udp 464/udp 123/udp 7389 9443 9444 9445

ENTRYPOINT /usr/sbin/ipa-server-configure-first
