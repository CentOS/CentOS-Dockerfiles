#!/usr/bin/env bash

# Permissions
export USER_ID=$(id -u);
export GROUP_ID=$(id -g);
envsubst < /opt/scripts/passwd.template > /tmp/passwd;
export LD_PRELOAD=libnss_wrapper.so;
export NSS_WRAPPER_PASSWD=/tmp/passwd;
export NSS_WRAPPER_GROUP=/etc/group;

# Initialize and validate variables
DB_TYPE=${DB_TYPE:-"pgsql"};
DB_LIBRARY=${DB_LIBRARY:-"native"};
DB_HOST=${DB_HOST:-"localhost"};
DB_NAME=${DB_NAME:-"moodle"};
DB_USER=${DB_USER:-"moodle"};
DB_PASSWD=${DB_PASSWD:-"moodle"};
MOODLE_URL=${MOODLE_URL:-"http://`hostname -i`:8080"}

# Main Begins

if [ $1 == "moodle" ]; then

    if [ ${DB_TYPE} == "oci" ]; then
        echo "Oracle database is not currently supported due to licensing issues with their client";
        exit 1
    fi

    sed -e "s/pgsql/${DB_TYPE}/
    s/username/${DB_USER}/
    s/password/${DB_PASSWD}/
    s/http:\/\/example.com\/moodle/${MOODLE_URL}/
    s/localhost/${DB_HOST}/
    s/\/home\/example\/moodledata/\/var\/moodledata/" /var/www/html/config-dist.php > /var/www/html/config.php;

    exec /usr/sbin/httpd -DFOREGROUND;
else
    exec $@
fi
