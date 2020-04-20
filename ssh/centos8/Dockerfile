FROM centos:centos8
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN dnf install -y openssh-server
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ''; \
	ssh-keygen -t ed25519 -f /etc/ssh/ssh_host_ed25519_key -N ''; \
	ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N ''
RUN SSH_USERNAME=root; \
	SSH_PASSWORD=root; \
	echo $SSH_USERNAME:$SSH_PASSWORD | chpasswd; \
	echo ssh username: $SSH_USERNAME; \
	echo ssh user password: $SSH_PASSWORD

EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd", "-D"]

