FROM centos/kubernetes-master
MAINTAINER The CentOS Project <cloud-ops@centos.org>

COPY launch.sh /usr/bin/kube-apiserver-docker.sh

ENTRYPOINT ["/usr/bin/kube-apiserver-docker.sh"]
