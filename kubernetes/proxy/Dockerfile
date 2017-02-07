FROM centos/kubernetes-node
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN yum install -y iptables conntrack-tools && yum clean all

LABEL RUN='/usr/bin/docker run -d --net=host --privileged ${OPT1} --name ${NAME} ${IMAGE} ${OPT3}'

COPY launch.sh /usr/bin/kube-proxy-docker.sh

ENTRYPOINT ["/usr/bin/kube-proxy-docker.sh"]

