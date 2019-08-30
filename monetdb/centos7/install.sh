#!/usr/bin/env bash

# Initialize Variables

set -eux;

EPEL="epel-release";
BASIC_PACKAGES="nss_wrapper gettext supervisor";
TMP_PAKCAGES="wget";

MONETDB_REPO="http://dev.monetdb.org/downloads/epel/MonetDB-release-epel-1.1-1.monetdb.noarch.rpm";
MONETDB_GPG_KEY="http://dev.monetdb.org/downloads/MonetDB-GPG-KEY";

CORE_PACKAGES="MonetDB-SQL-server5-hugeint MonetDB-client";

MONETDB_HOME="/opt/monetdb"
MONETDB_DATA="/var/monetdbdata"
MONETDB_FARM_DIR="${MONETDB_DATA}/db"

# Install begins

# * Create monetdbuser

useradd -u 1001 -g 0 -d ${MONETDB_HOME} monetdb;
mkdir -p ${MONETDB_DATA} && touch ${MONETDB_HOME}/supervisord.conf

# * EPEL and basic packages

yum -y install ${EPEL} && yum -y install ${BASIC_PACKAGES} ${TMP_PAKCAGES};

# * MonetDB Repo Setup

rpm --import ${MONETDB_GPG_KEY} && yum -y install ${MONETDB_REPO};

# * MonetDB Packages

yum -y install ${CORE_PACKAGES};

# * Fix the permissions

for item in ${MONETDB_HOME} ${MONETDB_DATA}; do
    . /opt/scripts/fix-permissions.sh ${item} monetdb;
    chmod -R g+s ${item};
done

# Clean up
yum -y remove ${TMP_PAKCAGES} && yum clean all;