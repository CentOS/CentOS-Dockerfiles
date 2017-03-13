FROM centos/kubernetes-master
MAINTAINER The CentOS Project <cloud-ops@centos.org>

LABEL Name="kubernetes-apiserver" \
      Version="1.5.2-0.2"

COPY launch.sh /usr/bin/kube-apiserver-docker.sh

ENTRYPOINT ["/usr/bin/kube-apiserver-docker.sh"]
