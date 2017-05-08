#!/usr/bin/env bash

# Permissions
export USER_ID=$(id -u);
export GROUP_ID=$(id -g);
envsubst < /opt/scripts/passwd.template > /tmp/passwd;
export LD_PRELOAD=libnss_wrapper.so;
export NSS_WRAPPER_PASSWD=/tmp/passwd;
export NSS_WRAPPER_GROUP=/etc/group;

# Main Begins

if [ $1 == "review" ]; then
    DOMAIN_NAME=${DOMAIN_NAME:-"`hostname -i`"};
    SITE_ROOT=${SITE_ROOT:-"/"};

    DB_TYPE=${DB_TYPE:-"sqlite3"};
    DB_HOST=${DB_HOST:-"localhost"}
    DB_NAME=${DB_NAME:-"/opt/data/database.sqllite3"};
    DB_USER=${DB_USER:-""};
    DB_PASSWD=${DB_PASSWD:-""};

    CACHE_TYPE=${CACHE_TYPE:-"file"};
    CACHE_INFO=${CACHE_INFO:-"/opt/data/cachefile"};

    ADMIN_USER=${ADMIN_USER:-"admin"};
    ADMIN_PASSWD=${ADMIN_PASSWD:-"admin"};
    ADMIN_EMAIL=${ADMIN_EMAIL:-"admin@example.com"};

    SITE_OPTIONS="--domain-name ${DOMAIN_NAME} --site-root ${SITE_ROOT}";

    DB_OPTIONS="--db-type ${DB_TYPE} --db-name ${DB_NAME} --db-host ${DB_HOST}";
    if [ ! -z ${DB_USER} ]; then
        DB_OPTIONS="${DB_OPTIONS} --db-user ${DB_USER}"
    fi
    if [ ! -z ${DB_PASSWD} ]; then
        DB_OPTIONS="${DB_OPTIONS} --db-pass ${DB_PASSWD}"
    fi

    CACHE_OPTIONS="--cache-type ${CACHE_TYPE} --cache-info ${CACHE_INFO}";
    ADMIN_OPTIONS="--admin-user ${ADMIN_USER} --admin-password ${ADMIN_PASSWD} --admin-email ${ADMIN_EMAIL}"

    OPTIONS="${SITE_OPTIONS} ${DB_OPTIONS} ${CACHE_OPTIONS} ${ADMIN_OPTIONS}"
    INSTALL_CMD1="rb-site install --noinput --web-server-port=8080 ${OPTIONS} /var/www/reviewboard";

    ${INSTALL_CMD1} && cat /var/www/reviewboard/conf/apache-wsgi.conf > /etc/httpd/conf.d/reviewboard.conf;

    exec /usr/sbin/httpd -DFOREGROUND;
else
    exec $@
fi