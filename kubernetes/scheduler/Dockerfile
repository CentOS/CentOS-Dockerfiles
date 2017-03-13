FROM centos/kubernetes-master
MAINTAINER The CentOS Project <cloud-ops@centos.org>

LABEL Name="kubernetes-scheduler" \
      Version="1.5.2-0.2"

COPY launch.sh /usr/bin/kube-scheduler-docker.sh

ENTRYPOINT ["/usr/bin/kube-scheduler-docker.sh"]
