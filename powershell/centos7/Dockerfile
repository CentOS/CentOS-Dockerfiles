FROM centos:latest
MAINTAINER The CentOS Project

LABEL Name="centos/powershell"

RUN yum -y --setopt=tsflags=nodocs update && \
    yum -y install https://github.com/PowerShell/PowerShell/releases/download/v6.1.0/powershell-6.1.0-1.rhel.7.x86_64.rpm && \
    yum clean all

CMD [ "/usr/bin/pwsh" ]
