#!/bin/bash

COUCH_URL="https://www.apache.org/dist/couchdb/source/1.6.1/apache-couchdb-1.6.1.tar.gz"
COUCH_CONFIG_DIR="/usr/local/etc/couchdb"
COUCH_TAR="apache-couchdb-1.6.1.tar.gz"
COUCH_DIR="apache-couchdb-1.6.1"
COUCH_DEP="wget make autoconf autoconf-archive automake libtool perl-Test-Harness erlang libicu-devel js-devel curl-devel gcc-c++"
CLEANUP_PKGS="wget make"

# Install epel
yum -y install epel-release;

# Install couchdb dependencies
yum -y install ${COUCH_DEP} && yum clean all

# Download and install couchdb
wget ${COUCH_URL};
tar -xzf ${COUCH_TAR};
cd ${COUCH_DIR};
/bin/sh ./configure --with-erlang=/usr/lib64/erlang/usr/include;
make && make install;

# Add couchdb user and proper file ownerships and permissions
adduser -r --home /usr/local/var/lib/couchdb -M --shell /bin/bash --comment "CouchDB Administrator" couchdb;
chown -R couchdb:couchdb /usr/local/etc/couchdb;
chown -R couchdb:couchdb /usr/local/var/lib/couchdb;
chown -R couchdb:couchdb /usr/local/var/log/couchdb;
chown -R couchdb:couchdb /usr/local/var/run/couchdb;
chmod 0770 /usr/local/etc/couchdb;
chmod 0770 /usr/local/var/lib/couchdb;
chmod 0770 /usr/local/var/log/couchdb;
chmod 0770 /usr/local/var/run/couchdb;

# Configure couchdb to listen at 0.0.0.0
sed -e 's/^bind_address = .*$/bind_address = 0.0.0.0/' -i "${COUCH_CONFIG_DIR}/default.ini"

# Cleanup unnessasary stuff
yum -y remove ${CLEANUP_PKGS} && yum clean all;
cd ..;
rm -rf ${COUCH_DIR}*
