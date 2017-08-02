FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

RUN yum -y update && yum clean all
RUN groupadd -g 994 kube && useradd -u 996 -g 994 kube

COPY virt7-container-common-candidate.repo /etc/yum.repos.d/
 
RUN yum install -y kubernetes-node --setopt=tsflags=nodocs --enablerepo=virt7-container-common-candidate && yum clean all
