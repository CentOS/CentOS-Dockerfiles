FROM centos/kubernetes-master
MAINTAINER The CentOS Project <cloud-ops@centos.org>

LABEL Name="kubernetes-scheduler" \
      Version="1.5.2-0.2"

COPY launch.sh /usr/bin/kube-scheduler-docker.sh

LABEL RUN /usr/bin/docker run -d --net=host

COPY service.template config.json.template /exports/

RUN mkdir -p /exports/hostfs/etc/kubernetes && cp /etc/kubernetes/{config,scheduler} /exports/hostfs/etc/kubernetes

ENTRYPOINT ["/usr/bin/kube-scheduler-docker.sh"]
