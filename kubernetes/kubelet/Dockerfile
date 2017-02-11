FROM centos/kubernetes-node
MAINTAINER The CentOS Project <cloud-ops@centos.org>

# NOTE: kubelet wants pidof (from sysvinit-tools), but it can't use it
# properly in a container, so we skip installing it

# Containerized kubelet requires nsenter
RUN yum install -y util-linux ethtool && yum clean all

# cAdvisor wants /etc/machine-id
# containerized kubelet needs /:/rootfs and /var/lib/kubelet to mount volumes
LABEL RUN='/usr/bin/docker run -d --privileged --net=host ${OPT1} -v /sys:/sys:ro -v /var/run/docker.sock:/var/run/docker.sock -v /var/lib/docker:/var/lib/docker -v /etc/machine-id:/etc/machine-id:ro -v /var/lib/kubelet:/var/lib/kubelet -v /:/rootfs --name ${NAME} ${IMAGE} ${OPT3}'

COPY launch.sh /usr/bin/kubelet-docker.sh

ENTRYPOINT ["/usr/bin/kubelet-docker.sh"]
