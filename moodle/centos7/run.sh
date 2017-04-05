#!/usr/bin/env bash

export USER_ID=$(id -u);
export GROUP_ID=$(id -g);
envsubst < /opt/scripts/passwd.template > /tmp/passwd;
export LD_PRELOAD=libnss_wrapper.so;
export NSS_WRAPPER_PASSWD=/tmp/passwd;
export NSS_WRAPPER_GROUP=/etc/group;

DB_TYPE=${DB_TYPE:-"pgsql"};
DB_LIBRARY=${DB_LIBRARY:-"native"};
DB_HOST=${DB_HOST:-"localhost"};
DB_NAME=${DB_NAME:-"moodle"};
DB_USER=${DB_USER:-"moodle"};
DB_PASSWD=${DB_PASSWD:-"moodle"};
if [ -z ${MOODLE_HOST} ]; then
    MOODLE_HOST="`hostname -i`";
fi

if [ -z ${MOODLE_HOST_NOPORT} ]; then
    if [[ ${MOODLE_HOST} != *":"* ]]; then
        MOODLE_HOST="${MOODLE_HOST}:8080"
    fi
fi

if [ $1 == "moodle" ]; then
    sed -e "s/pgsql/${DB_TYPE}/
    s/username/${DB_USER}/
    s/password/${DB_PASSWD}/
    s/http:\/\/example.com\/moodle/http:\/\/${MOODLE_HOST}/
    s/localhost/${DB_HOST}/
    s/\/home\/example\/moodledata/\/var\/moodledata/" /var/www/html/config-dist.php > /var/www/html/config.php;

    exec /usr/sbin/httpd -DFOREGROUND;
else
    exec $@
fi
