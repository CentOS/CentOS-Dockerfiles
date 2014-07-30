# "ported" by Adam Miller <maxamillion@fedoraproject.org> from
#   https://github.com/fedora-cloud/Fedora-Dockerfiles
#
# Originally written for Fedora-Dockerfiles by
#   "Maciej Lasyk" <maciek@lasyk.info>

FROM centos:centos6
MAINTAINER The CentOS Project <cloud-ops@centos.org>

# install main packages:
RUN yum -y update; yum clean all
RUN yum -y install centos-release-SCL; yum clean all
RUN yum -y install openssl-devel openssl readline readline-devel gcc gcc-c++ ruby193-rubygems ruby193-rubygems-devel ruby193-ruby ruby193-ruby-devel; yum clean all

# install earthquake
RUN scl enable ruby193 'gem install earthquake'

# Add in the entrypoint script to handle SCL bits
ADD docker-entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

# set the env:
RUN useradd -d /home/twitter twitter
USER twitter 
ENV HOME /home/twitter
WORKDIR /home/twitter

CMD ["/entrypoint.sh"]
