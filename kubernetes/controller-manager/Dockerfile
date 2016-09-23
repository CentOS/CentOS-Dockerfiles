FROM centos/kubernetes-master
MAINTAINER The CentOS Project <cloud-ops@centos.org>

COPY launch.sh /usr/bin/kube-controller-manager-docker.sh

ENTRYPOINT ["/usr/bin/kube-controller-manager-docker.sh"]
