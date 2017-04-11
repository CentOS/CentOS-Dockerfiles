#!/usr/bin/env bash

set -eux;

# Initialize Variables

ELASTIC_SEARCH_GPG_KEY="https://artifacts.elastic.co/GPG-KEY-elasticsearch"
ELASTIC_REPO_FILE_LOCATION="/etc/yum.repos.d/elastic.repo"
ELASTIC_CONFIG="/etc/elasticsearch/elasticsearch.yml"
ELASTIC_CONFIG_BAK="/etc/elasticsearch/elasticsearch.yml.bak"
ELASTIC_MAJOR_VERSION=${ELASTIC_MAJOR_VERSION:-"5.x"}
BASIC_PACKAGES="java-1.8.0-openjdk nss_wrapper gettext"
SYSCTL_CONF="/etc/sysctl.conf"

# Install Begins

# Install epel
yum -y install epel-release;

# Configure Elastic Repo
cat >${ELASTIC_REPO_FILE_LOCATION} <<EOF
[ElasticSearch]
name=Elasticsearch repository for ${ELASTIC_MAJOR_VERSION} packages
baseurl=https://artifacts.elastic.co/packages/${ELASTIC_MAJOR_VERSION}/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

# Create elasticsearch user
useradd -u 1001 -g 0 elasticsearch

# Install basic packages
yum -y install ${BASIC_PACKAGES};

# Install elastic search
yum -y install elasticsearch;
ln -s /etc/elasticsearch/ /usr/share/elasticsearch/config
cp ${ELASTIC_CONFIG} ${ELASTIC_CONFIG_BAK}

for item in "/usr/share/elasticsearch" "/etc/elasticsearch" "/var/lib/elasticsearch" "/etc/sysconfig/elasticsearch"; do
    . /opt/scripts/fix-permissions.sh ${item} elasticsearch
done

# Cleanup
yum clean all