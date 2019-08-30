#!/usr/bin/env bash

set -eux

# Setup Envs

BASE_PACKAGES="epel-release centos-release-scl"
CORE_PACKAGES="gettext"
TMP_PACKAGES="git wget"

NODE_VERSION=${NODE_VERSION:="v6.9.4"}
ARCH=${ARCH:="x64"}
NODE_NAME="node-${NODE_VERSION}-linux-${ARCH}"
NODE_TAR="${NODE_NAME}.tar.xz"
NODE_DIR="/opt/nodejs"

NODE_DOWNLOAD="https://nodejs.org/dist/${NODE_VERSION}/${NODE_TAR}"

HASTE_REPO="https://github.com/seejohnrun/haste-server.git"
HASTE_DIR="/opt/hastebin-server"
HASTE_DATA_DIR="/opt/data"

# Install begins
# * Setup basics
yum -y install ${BASE_PACKAGES} && yum -y install --skip-broken ${CORE_PACKAGES} ${TMP_PACKAGES};

# ** Install full nodejs

wget ${NODE_DOWNLOAD} && tar -xf ${NODE_TAR} && mv ${NODE_NAME}/* ${NODE_DIR} \
       	&& rm -rf ${NODE_NAME}*;
useradd -u 1001 -g 0 -d ${HASTE_DIR} nodejsuser;

# * Setup hastebin server
git clone https://github.com/seejohnrun/haste-server.git _tmp && cp -avrf _tmp/* ${HASTE_DIR} && rm -rf _tmp;

pushd ${HASTE_DIR} && npm install && popd;

for item in ${HASTE_DIR} ${HASTE_DATA_DIR} ${NODE_DIR}; do
    . /opt/scripts/fix-permissions.sh ${item} nodejsuser;
done

# Cleanup
yum -y remove ${TMP_PACKAGES} && yum clean all
