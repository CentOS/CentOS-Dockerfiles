FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN yum -y update && yum clean all
RUN yum install -y kubernetes-node findutils && yum clean all
