FROM centos:latest
MAINTAINER The CentOS Project

LABEL Name="centos/powershell"

RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y install https://github.com/PowerShell/PowerShell/releases/download/v6.0.0-alpha.9/powershell-6.0.0_alpha.9-1.el7.centos.x86_64.rpm && \
    yum clean all

CMD [ "/usr/bin/powershell" ]
