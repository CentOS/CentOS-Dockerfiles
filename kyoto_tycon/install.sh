#!/usr/bin/env bash


set -eux

INSTALL_PKGS1="make gcc-c++ zlib-devel lzo-devel lzma-devel xz-devel lua-devel";
INSTALL_PKGS2="wget ${INSTALL_PKGS1}";

KYOTO_DOWNLOAD="http://fallabs.com";
KYOTO_CABINET="kyotocabinet-1.2.76";
KYOTO_CABINET_TARBALL="${KYOTO_CABINET}.tar.gz";
KYOTO_CABINET_DOWNLOAD="${KYOTO_DOWNLOAD}/kyotocabinet/pkg/${KYOTO_CABINET_TARBALL}"
KYOTO_TYCOON="kyototycoon-0.9.56";
KYOTO_TYCOON_TARBALL="${KYOTO_TYCOON}.tar.gz";
KYOTO_TYCOON_DOWNLOAD="${KYOTO_DOWNLOAD}/kyototycoon/pkg/${KYOTO_TYCOON_TARBALL}"

SRC_DIR="/usr/local/src/kyoto/"
RUN_DIR="/usr/local/sbin/"
INITD_DIR="/etc/rc.d/init.d/"
KT_SERV="ktservctl"
KYOTO_EXEC_SRC="${SRC_DIR}tycoon/lab/${KT_SERV}"

# Create user
useradd -u 1001 -g 0 kyoto

# Install necessary packages
yum -y install ${INSTALL_PKGS2};

# Install Kyoto cabinet
wget ${KYOTO_CABINET_DOWNLOAD};
tar zxfv ${KYOTO_CABINET_TARBALL} && mv ${KYOTO_CABINET} cabinet;
pushd cabinet && ./configure && make && make install && popd;

# Install Kyoto Tycoon
wget ${KYOTO_TYCOON_DOWNLOAD};
tar zxfv ${KYOTO_TYCOON_TARBALL} && mv ${KYOTO_TYCOON} tycoon;
sed -i '24a\#include <unistd.h>' ${SRC_DIR}tycoon/ktdbext.h;
pushd tycoon && ./configure && make && make install && popd;
cp ${KYOTO_EXEC_SRC} ${RUN_DIR} && chmod +rx ${RUN_DIR}/${KT_SERV};
cp ${KYOTO_EXEC_SRC} ${INITD_DIR}ktserver && chmod +rx ${INITD_DIR}ktserver

# Add memcache interchangable
sed -i '65a\cmd="$cmd -plsv /usr/local/src/kyoto/tycoon/ktplugservmemc.so"' ${INITD_DIR}ktserver
sed -i '66a\cmd="$cmd -plex port=11401#opts=f#tout=10"' ${INITD_DIR}ktserver

# Add setting
sed -i '$ a /usr/local/lib' /etc/ld.so.conf

# Setup Permissions
for item in /var/ktserver ${SRC_DIR} ${INITD_DIR}; do
    . /opt/scripts/fix-permissions.sh ${item}
done

# Cleanup
yum -y remove ${INSTALL_PKGS1}
yum clean all;
rm -rf /tmp/* /var/tmp/* ${KYOTO_CABINET_TARBALL} ${KYOTO_TYCOON_TARBALL};
