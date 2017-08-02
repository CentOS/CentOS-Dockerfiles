FROM centos/kubernetes-sig-master
MAINTAINER The CentOS Project <cloud-ops@centos.org>

COPY launch.sh /usr/bin/kube-controller-manager-docker.sh

COPY service.template config.json.template /exports/

RUN mkdir -p /exports/hostfs/etc/kubernetes && cp /etc/kubernetes/{config,controller-manager} /exports/hostfs/etc/kubernetes

ENTRYPOINT ["/usr/bin/kube-controller-manager-docker.sh"]
