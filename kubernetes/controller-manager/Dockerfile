FROM centos/kubernetes-master
MAINTAINER The CentOS Project <cloud-ops@centos.org>

LABEL Name="kubernetes-controller-manager" \
      Version="1.5.2-0.2"

COPY launch.sh /usr/bin/kube-controller-manager-docker.sh

ENTRYPOINT ["/usr/bin/kube-controller-manager-docker.sh"]
