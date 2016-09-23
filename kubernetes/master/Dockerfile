FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN yum -y update && yum clean all
RUN yum install -y kubernetes-master && yum clean all
