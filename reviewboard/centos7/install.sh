#!/usr/bin/env bash

set -eux;

# Initialize variables
HTTPD_CONF="/etc/httpd/conf/httpd.conf"
HTTPD_WELCOME="/etc/httpd/conf.d/welcome.conf"
WSGI_CONFIG="/etc/httpd/conf.d/reviewboard.conf"

EPEL="epel-release"
TMP_PKGS="wget";
BASIC_PKGS="httpd mod_wsgi nss_wrapper gettext";
CORE_PKGS="ReviewBoard memcached python-memcached cvs git subversion python-subvertpy"

# Install Begins

#* Setup basic
yum -y install ${EPEL} && yum -y install ${BASIC_PKGS} && yum -y install ${CORE_PKGS};

# Fixup Configurations
rm -rf ${HTTPD_WELCOME};
sed -i 's/^Listen 80/Listen 8080\\\nListen 8443/g' ${HTTPD_CONF};
sed -i 's/^Listen 8080\\/Listen 8080/g' ${HTTPD_CONF};
sed -i 's/^Group apache/Group root/g' ${HTTPD_CONF};
sed -i 's/logs\/error_log/\/dev\/stderr/g' ${HTTPD_CONF};
sed -i 's/logs\/access_log/\/dev\/stdout/g' ${HTTPD_CONF};
mkdir -p /etc/httpd/logs && touch /etc/httpd/logs/error_log && touch /etc/httpd/logs/access_log && touch ${WSGI_CONFIG};

# Fix the permissions
for item in "/etc/httpd" "/var/www" "/opt/data"; do
    . /opt/scripts/fix-permissions.sh ${item} apache;
    chmod -R g+s ${item};
done

chmod -R 777 /etc/httpd/logs;

# Cleanup
yum clean all;
