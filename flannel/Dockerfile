FROM centos

MAINTAINER The CentOS Project <cloud-ops@centos.org>

ENV container=docker
ENV FLANNELD_ETCD_ENDPOINTS="http://127.0.0.1:2379"
ENV FLANNELD_ETCD_PREFIX="/atomic.io/network"

RUN yum -y install flannel && yum clean all

ADD flanneld-run.sh /usr/bin/

# System container files
COPY tmpfiles.template service.template manifest.json \
     config.json.template /exports/

CMD ["/usr/bin/flanneld-run.sh"]
