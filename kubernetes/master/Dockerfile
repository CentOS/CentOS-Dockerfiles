FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

LABEL Name="kubernetes-master" \
      Version="1.5.2-0.2"

RUN yum -y update && yum clean all
RUN groupadd -g 994 kube && useradd -u 996 -g 994 kube
RUN yum install -y kubernetes-master && yum clean all
