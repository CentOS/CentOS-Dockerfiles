FROM centos/kubernetes-sig-master
MAINTAINER The CentOS Project <cloud-ops@centos.org>

COPY launch.sh /usr/bin/kube-scheduler-docker.sh

LABEL RUN /usr/bin/docker run -d --net=host

COPY service.template config.json.template /exports/

RUN mkdir -p /exports/hostfs/etc/kubernetes && cp /etc/kubernetes/{config,scheduler} /exports/hostfs/etc/kubernetes

ENTRYPOINT ["/usr/bin/kube-scheduler-docker.sh"]
