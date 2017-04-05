#!/usr/bin/env bash

set -eux;

# Initialize variables
HTTPD_CONF="/etc/httpd/conf/httpd.conf"
HTTPD_WELCOME="/etc/httpd/conf.d/welcome.conf"

INSTALL_PKGS1="wget";
INSTALL_PKGS2="httpd nss_wrapper gettext";

PHP_PACKAGES1="php php-mysql php-pgsql php-xml php-xmlrpc php-gd php-mongodb php-pecl-apcu mssql-tools redis freetds";
PHP_PACKAGES2="php-pecl-zendopcache php-pecl-memcache php-pecl-memcached php-intl php-soap php-xmlrpc php-mbstring";
PHP_PACKAGES3="php-pecl-solr php-pecl-solr2 "

PHP_PACKAGES="${PHP_PACKAGES1} ${PHP_PACKAGES2} ${PHP_PACKAGES3}"
INSTALL_PKGS="${INSTALL_PKGS1} ${INSTALL_PKGS2} ${PHP_PACKAGES}"

MOODLE="moodle"
MOODLE_DOWNLOAD_BASE="https://download.moodle.org"
MOODLE_VERSION=${MOODLE_VERSION-"latest"}
MOODLE_NODOT_VERSION=${MOODLE_NODOT_VERSION:-"moodle"}
MOODLE_TAR="${MOODLE}-${MOODLE_VERSION}.tgz"
MOODLE_DOWNLOAD_URL="${MOODLE_DOWNLOAD_BASE}/${MOODLE_NODOT_VERSION}/${MOODLE_TAR}"
OPCACHE_INI_LOC="/etc/php.d/opcache.ini"
MSSQL_REPODATA="https://packages.microsoft.com/config/rhel/7/prod.repo"

export ACCEPT_EULA="Y"
export MOODLE_DATA="/var/moodledata"

# Setup repositories
pushd /etc/yum.repos.d && wget ${MSSQL_REPODATA} && popd

# Setup necessary packages
yum -y install epel-release && yum -y install --skip-broken ${INSTALL_PKGS};

# Install moodle
pushd /var/www;
wget ${MOODLE_DOWNLOAD_URL} && tar zxvf ${MOODLE_TAR} && mv /var/www/${MOODLE}/* /var/www/html;
mkdir -p /var/moodledata
popd;

# Fixup Configurations
rm -rf ${HTTPD_WELCOME};
sed -i 's/^Listen 80/Listen 8080\\\nListen 8443/g' ${HTTPD_CONF};
sed -i 's/^Listen 8080\\/Listen 8080/g' ${HTTPD_CONF};
sed -i 's/^Group apache/Group root/g' ${HTTPD_CONF};
mkdir -p /etc/httpd/logs && touch /etc/httpd/logs/error_log && touch /etc/httpd/logs/access_log;

# Fix the permissions
for item in "/etc/httpd" "/var/www" "/var/moodledata"; do
    . /opt/scripts/fix-permissions.sh ${item} apache;
done

chmod -R 777 /etc/httpd/logs;

# Enable opcache
cat <<EOT > ${OPCACHE_INI_LOC}
[opcache]
opcache.enable = 1
opcache.memory_consumption = 64
opcache.max_accelerated_files = 8000
opcache.revalidate_freq = 60

; Required for Moodle
opcache.use_cwd = 1
opcache.validate_timestamps = 1
opcache.save_comments = 1
opcache.enable_file_override = 0
EOT

# Cleanup
yum -y remove ${INSTALL_PKGS1} && yum clean all