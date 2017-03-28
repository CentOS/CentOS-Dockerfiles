#!/usr/bin/env bash

set -eux

INSTALL_PKGS1="wget";
INSTALL_PKGS2="${INSTALL_PKGS1} make gcc-c++ zlib-devel lzo-devel lzma-devel xz-devel lua-devel";

KYOTO_DOWNLOAD="http://fallabs.com";
KYOTO_CABINET="kyotocabinet-1.2.76";
KYOTO_CABINET_TARBALL="${KYOTO_CABINET}.tar.gz";
KYOTO_CABINET_DOWNLOAD="${KYOTO_DOWNLOAD}/kyotocabinet/pkg/${KYOTO_CABINET_TARBALL}"
KYOTO_TYCOON="kyototycoon-0.9.56";
KYOTO_TYCOON_TARBALL="${KYOTO_TYCOON}.tar.gz";
KYOTO_TYCOON_DOWNLOAD="${KYOTO_DOWNLOAD}/kyototycoon/pkg/${KYOTO_TYCOON_TARBALL}"

SRC_DIR="/usr/local/src/"
RUN_DIR="/usr/local/sbin/"
INITD_DIR="/etc/rc.d/init.d/"
KT_SERV="ktservctl"
KYOTO_EXEC_SRC="${SRC_DIR}${KYOTO_TYCOON}/lab/${KT_SERV}"

# Install necessary packages
yum -y install ${INSTALL_PKGS2};

# Install Kyoto cabinet
wget ${KYOTO_CABINET_DOWNLOAD};
tar zxfv ${KYOTO_CABINET_TARBALL};
pushd ${KYOTO_CABINET} && ./configure && make && make install && popd;

# Install Kyoto Tycoon
wget ${KYOTO_TYCOON_DOWNLOAD};
tar zxfv ${KYOTO_TYCOON_TARBALL};
sed -i '24a\#include <unistd.h>' ${SRC_DIR}${KYOTO_TYCOON}/ktdbext.h;
pushd ${KYOTO_TYCOON} && ./configure && make && make install && popd;
cp ${KYOTO_EXEC_SRC} ${RUN_DIR} && chmod +rx ${RUN_DIR}/${KT_SERV};
cp ${KYOTO_EXEC_SRC} ${INITD_DIR}ktserver && chmod +rx ${INITD_DIR}ktserver

# Add memcache interchangable
sed -i '65a\cmd="$cmd -plsv /usr/local/src/kyototycoon-0.9.56/ktplugservmemc.so"' ${INITD_DIR}ktserver
sed -i '66a\cmd="$cmd -plex port=11401#opts=f#tout=10"' ${INITD_DIR}ktserver

# Add setting
sed -i '$ a /usr/local/lib' /etc/ld.so.conf

# Cleanup
yum clean all;
rm -rf /tmp/* /var/tmp/* ${KYOTO_CABINET_TARBALL} ${KYOTO_TYCOON_TARBALL};
