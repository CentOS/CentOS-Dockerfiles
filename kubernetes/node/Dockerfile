FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

LABEL Name="kubernetes-node" \
      Version="1.5.2-0.2"

RUN yum -y update && yum clean all
RUN yum install -y kubernetes-node findutils && yum clean all
