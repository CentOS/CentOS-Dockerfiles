FROM centos/kubernetes-master
MAINTAINER The CentOS Project <cloud-ops@centos.org>

COPY launch.sh /usr/bin/kube-scheduler-docker.sh

ENTRYPOINT ["/usr/bin/kube-scheduler-docker.sh"]
