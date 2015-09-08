FROM fedora/kubernetes-node
MAINTAINER Solly Ross <sross@redhat.com>

RUN yum install -y iptables && yum clean all

LABEL RUN='/usr/bin/docker run -d --net=host --privileged ${OPT1} --name ${NAME} ${IMAGE} ${OPT3}'

COPY launch.sh /usr/bin/kube-proxy-docker.sh

ENTRYPOINT ["/usr/bin/kube-proxy-docker.sh"]

