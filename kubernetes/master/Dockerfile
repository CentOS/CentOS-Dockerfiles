FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN yum -y update && yum clean all
RUN groupadd -g 994 kube && useradd -u 996 -g 994 kube
RUN yum install -y kubernetes-master && yum clean all
