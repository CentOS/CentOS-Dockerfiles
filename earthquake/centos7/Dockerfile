# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   "Maciej Lasyk" <maciek@lasyk.info>

FROM centos:centos7
MAINTAINER The CentOS Project <cloud-ops@centos.org>

# install main packages:
RUN yum -y update; yum clean all
RUN yum -y install openssl-devel openssl readline readline-devel gcc gcc-c++ rubygems rubygems-devel ruby ruby-devel; yum clean all

# install earthquake
RUN gem install activesupport -v 4.2.7.1
RUN gem install earthquake

# set the env:
RUN useradd -d /home/twitter twitter
USER twitter
ENV HOME /home/twitter
WORKDIR /home/twitter

CMD ["earthquake"]
