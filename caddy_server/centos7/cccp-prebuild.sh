#!/usr/bin/env bash

set -eux;

BUILD_DIR="/opt/cccp/caddy-build";

CADDY_BIN="caddy"
CADDY_MAIN_SRC_REPO="github.com/mholt/caddy";
CADDY_MAIN_BUILDS_REPO="github.com/caddyserver/builds";

CADDY_SRC_BUILD_REMOTE_NAME="caddy_build"
CADDY_SRC_BUILD_REMOTE_URL="https://github.com/mohammedzee1000/caddy"
CADDY_SRC_BUILD_REMOTE_BRANCH="centos_release"

CADDY_PLUGIN_AUTH="github.com/casbin/caddy-authz";
CADDY_PLUGIN_AWSES="github.com/miquella/caddy-awses";
CADDY_PLUGIN_PROMETHEUS="github.com/miekg/caddy-prometheus";

# CREATE/RE_CREATE BUILD DIR

if [ -d ${BUILD_DIR} ]; then
    rm -rf ${BUILD_DIR};
fi
mkdir ${BUILD_DIR};

# GET INTO DIRECTORY AFTER RECORDING CURRENT PATH
CURR="`pwd`"
pushd ${BUILD_DIR};

# INSTALL GOLANG 1.9
yum -y install wget git;

wget http://cbs.centos.org/kojifiles/packages/golang/1.9.2/4.el7/noarch/golang-src-1.9.2-4.el7.noarch.rpm
wget http://cbs.centos.org/kojifiles/packages/golang/1.9.2/4.el7/x86_64/golang-bin-1.9.2-4.el7.x86_64.rpm
wget http://cbs.centos.org/kojifiles/packages/golang/1.9.2/4.el7/x86_64/golang-1.9.2-4.el7.x86_64.rpm
yum -y install golang-1.9.2-4.el7.x86_64.rpm golang-bin-1.9.2-4.el7.x86_64.rpm golang-src-1.9.2-4.el7.noarch.rpm

yum -y remove wget;
yum clean all;

# SETUP STUFF NEEDED TO BUILD BINARY
# - SET GOPATH
export GOPATH="${BUILD_DIR}";

# - GET THE MAIN REPOSITORIES
go get ${CADDY_MAIN_SRC_REPO};
go get ${CADDY_MAIN_BUILDS_REPO};

# - Get plugin deps
go get ${CADDY_PLUGIN_AUTH};
go get ${CADDY_PLUGIN_AWSES};
go get ${CADDY_PLUGIN_PROMETHEUS};

# - GET INTO THE SRC REPO AND MOVE TO mohammedzee1000 fork of caddy, centos-release branch
pushd "src/${CADDY_MAIN_SRC_REPO}";
git remote add ${CADDY_SRC_BUILD_REMOTE_NAME} ${CADDY_SRC_BUILD_REMOTE_URL};
git fetch ${CADDY_SRC_BUILD_REMOTE_NAME};
git checkout ${CADDY_SRC_BUILD_REMOTE_BRANCH};

# CD INTO THE DIRECTORY CONTAINING SCRIPT TO PERFORM ACTUAL BUILD OF BINARY
pushd "./caddy";

# Build the binary and copy it back to repo
go run build.go;
cp -avrf "./${CADDY_BIN}" "${CURR}/${CADDY_BIN}"

# POP OUT ALL DIRS
popd;
popd;
popd;

