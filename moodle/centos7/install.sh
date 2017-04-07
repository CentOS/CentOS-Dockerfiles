#!/usr/bin/env bash

set -eux;

# Initialize variables
HTTPD_CONF="/etc/httpd/conf/httpd.conf"
HTTPD_WELCOME="/etc/httpd/conf.d/welcome.conf"

INSTALL_PKGS1="wget";
INSTALL_PKGS2="httpd nss_wrapper gettext";
REMI_REPO="https://rpms.remirepo.net/enterprise/remi-release-7.rpm"
PHP_REMI_VERSION="${PHP_REMI_VERSION:-"php71"}"

PHP1="${PHP_REMI_VERSION} ${PHP_REMI_VERSION}-php ${PHP_REMI_VERSION}-php-pgsql ${PHP_REMI_VERSION}-php-mysqlnd"
PHP2="${PHP_REMI_VERSION}-php-pecl-mysql ${PHP_REMI_VERSION}-php-xml ${PHP_REMI_VERSION}-php-xmlrpc "
PHP3="${PHP_REMI_VERSION}-php-gd ${PHP_REMI_VERSION}-php-pecl-mongodb ${PHP_REMI_VERSION}-php-pecl-apcu"
PHP4="${PHP_REMI_VERSION}-php-pecl-apcu-bc ${PHP_REMI_VERSION}-php-pecl-redis ${PHP_REMI_VERSION}-php-phpiredis"
PHP5="${PHP_REMI_VERSION}-php-opcache ${PHP_REMI_VERSION}-php-pecl-memcache ${PHP_REMI_VERSION}-php-pecl-memcached"
PHP6="${PHP_REMI_VERSION}-php-intl ${PHP_REMI_VERSION}-php-mbstring ${PHP_REMI_VERSION}-php-pecl-solr2"
PHP7="${PHP_REMI_VERSION}-php-pecl-zip ${PHP_REMI_VERSION}-php-soap"

PHP_MSSQL_PACKAGES="${PHP_REMI_VERSION}-php-sqlsrv"
PHP_ORACLE_PACKAGES=""

PHP_PACKAGES="${PHP1} ${PHP2} ${PHP3} ${PHP4} ${PHP5} ${PHP6} ${PHP7} ${PHP_MSSQL_PACKAGES}";
INSTALL_PKGS="${INSTALL_PKGS2} ${PHP_PACKAGES}";

MOODLE="moodle";
MOODLE_DOWNLOAD_BASE="https://download.moodle.org";
MOODLE_VERSION=${MOODLE_VERSION-"latest"};
MOODLE_NODOT_VERSION=${MOODLE_NODOT_VERSION:-"moodle"};
MOODLE_TAR="${MOODLE}-${MOODLE_VERSION}.tgz";
MOODLE_DOWNLOAD_URL="${MOODLE_DOWNLOAD_BASE}/${MOODLE_NODOT_VERSION}/${MOODLE_TAR}";
MSSQL_REPODATA="https://packages.microsoft.com/config/rhel/7/prod.repo";

export ACCEPT_EULA="Y";
export MOODLE_DATA="/var/moodledata";

# INSTALL BEGINS

# Setup repositories
yum -y install ${INSTALL_PKGS1}
pushd /etc/yum.repos.d && wget ${MSSQL_REPODATA} && popd

# Setup necessary packages
yum -y install epel-release && yum -y install ${REMI_REPO} && yum -y install --skip-broken ${INSTALL_PKGS}

# Install moodle
pushd /var/www;
wget ${MOODLE_DOWNLOAD_URL} && tar zxvf ${MOODLE_TAR} && mv /var/www/${MOODLE}/* /var/www/html;
mkdir -p /var/moodledata && rm -rf ${MOODLE_TAR};
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

# Cleanup
yum -y remove ${INSTALL_PKGS1} && yum clean all

