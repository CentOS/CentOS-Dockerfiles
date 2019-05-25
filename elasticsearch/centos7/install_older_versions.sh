#!/usr/bin/env bash

set -eux;

# Initialize Variables

ELASTIC_CONFIG="/etc/elasticsearch/elasticsearch.yml"
ELASTIC_CONFIG_BAK="/etc/elasticsearch/elasticsearch.yml.bak"
ELASTIC_MAJOR_VERSION=${ELASTIC_MAJOR_VERSION:-"5.x"}
BASIC_PACKAGES="java-1.8.0-openjdk nss_wrapper gettext"
SYSCTL_CONF="/etc/sysctl.conf"

# Install Begins

# Install epel
yum -y install epel-release;

# Configure Elastic Repo
yum -y install https://download.elastic.co/elasticsearch/release/org/elasticsearch/distribution/rpm/elasticsearch/${ELASTIC_MAJOR_VERSION}/elasticsearch-${ELASTIC_MAJOR_VERSION}.rpm

# Install basic packages
yum -y install ${BASIC_PACKAGES};

# Install elastic search
yum -y install elasticsearch;
ln -s /etc/elasticsearch/ /usr/share/elasticsearch/config
cp ${ELASTIC_CONFIG} ${ELASTIC_CONFIG_BAK}

# Modify elasticsearch user
usermod -g 0 elasticsearch

for item in "/usr/share/elasticsearch" "/etc/elasticsearch" "/var/lib/elasticsearch" "/etc/sysconfig/elasticsearch"; do
    . /opt/scripts/fix-permissions.sh ${item} elasticsearch
done

# Cleanup
yum clean all