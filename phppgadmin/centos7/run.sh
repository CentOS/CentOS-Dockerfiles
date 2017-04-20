#!/usr/bin/env bash

export USER_ID=$(id -u);
export GROUP_ID=$(id -g);
envsubst < /opt/scripts/passwd.template > /tmp/passwd;
export LD_PRELOAD=libnss_wrapper.so;
export NSS_WRAPPER_PASSWD=/tmp/passwd;
export NSS_WRAPPER_GROUP=/etc/group;

PHP_PG_ADMIN_CONFIG="/etc/phpPgAdmin/config.inc.php"
POSTGRESQL_SERVER=${POSTGRESQL_SERVER:-"localhost"}

sed -i "s/conf\['servers'\]\[0\]\['host'\] = '.*'/conf\['servers'\]\[0\]\['host'\] = '${POSTGRESQL_SERVER}'/g" ${PHP_PG_ADMIN_CONFIG};

if [ $1 == "phppgadmin" ]; then
    exec /usr/sbin/httpd -DFOREGROUND;
else
    exec $1
fi
