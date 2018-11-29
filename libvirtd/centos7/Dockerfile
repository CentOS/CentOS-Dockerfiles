FROM centos/systemd

USER 0

RUN yum -y install libvirt-daemon-driver-* libvirt-daemon \
  libvirt-daemon-kvm qemu-kvm && yum clean all
RUN systemctl enable libvirtd; systemctl enable virtlockd

RUN yum install -y openssh-server openssh-clients arpwatch

RUN echo "root:root" |chpasswd
RUN systemctl enable sshd
RUN sed -i 's|[#]*PermitRootLogin no|PermitRootLogin yes|g' /etc/ssh/sshd_config
RUN sed -i 's|[#]*PasswordAuthentication no|PasswordAuthentication yes|g' /etc/ssh/sshd_config
RUN sed -i 's|[#]*ChallengeResponseAuthentication no|ChallengeResponseAuthentication yes|g' /etc/ssh/sshd_config
RUN sed -i 's|UsePAM no|UsePAM yes|g' /etc/ssh/sshd_config

RUN echo "listen_tls = 0" >> /etc/libvirt/libvirtd.conf; \
echo 'listen_tcp = 1' >> /etc/libvirt/libvirtd.conf; \
echo 'tls_port = "16514"' >> /etc/libvirt/libvirtd.conf; \
echo 'tcp_port = "16509"' >> /etc/libvirt/libvirtd.conf; \
echo 'auth_tcp = "none"' >> /etc/libvirt/libvirtd.conf

RUN echo 'vnc_listen = "0.0.0.0"' >> /etc/libvirt/qemu.conf

RUN echo 'LIBVIRTD_ARGS="--listen"' >> /etc/sysconfig/libvirtd

ADD customlibvirtpost.service /usr/lib/systemd/system/customlibvirtpost.service
ADD customlibvirtpost.sh /customlibvirtpost.sh
RUN chmod a+x /customlibvirtpost.sh
Add network.xml /network.xml
RUN systemctl enable customlibvirtpost

EXPOSE 22
EXPOSE 16509
EXPOSE 5900

VOLUME [ "/sys/fs/cgroup" ]
CMD ["/usr/sbin/init"]
