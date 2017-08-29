FROM centos/kubernetes-sig-master
MAINTAINER The CentOS Project <cloud-ops@centos.org>

COPY launch.sh /usr/bin/kube-apiserver-docker.sh

COPY service.template config.json.template tmpfiles.template /exports/

RUN chmod +x /usr/bin/kube-apiserver

RUN mkdir -p /exports/hostfs/usr/local/bin/ && cp /usr/bin/kubectl /exports/hostfs/usr/local/bin/kubectl

RUN mkdir -p /exports/hostfs/etc/kubernetes && cp /etc/kubernetes/{config,apiserver} /exports/hostfs/etc/kubernetes

ENTRYPOINT ["/usr/bin/kube-apiserver-docker.sh"]
