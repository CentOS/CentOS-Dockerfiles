#!/usr/bin/env bash

set -eux;

# Permissions
export USER_ID=$(id -u);
export GROUP_ID=$(id -g);
export HOME="/opt/monetdb"
envsubst < /opt/scripts/passwd.template > /tmp/passwd;
export LD_PRELOAD=libnss_wrapper.so;
export NSS_WRAPPER_PASSWD=/tmp/passwd;
export NSS_WRAPPER_GROUP=/etc/group;

export DATABASE_NAME=${DATABASE_NAME:-"db"};
export DATABASE_USER=${DATABASE_USER:-"monetdb"}
export DATABASE_PASSWD=${DATABASE_PASSWD:-"monetdb"}
export DATABASE_OLD_PASSWD=${DATABASE_OLD_PASSWD:-"monetdb"}

MONETDB_DATA="/var/monetdbdata";
MONETDB_FARM_DIR="${MONETDB_DATA}/db";
MONETDB_DATABASE_LOCATION="${MONETDB_FARM_DIR}/${DATABASE_NAME}"

TOUCH_PASSWD(){
    USR=$1
    PASSWD=$2
    PASSWD_FILE="${HOME}/.monetdb"
    echo -e "user=${USR}\npassword=${PASSWD}" > ${PASSWD_FILE}
}

DEL_PASSWD(){

    rm -rf "${HOME}/.monetdb"

}

SET_PASSWORD(){

    echo "Setting new password for database ${DATABASE_NAME} and user ${DATABASE_USER}";
    TOUCH_PASSWD ${DATABASE_USER} ${DATABASE_OLD_PASSWD};
    mclient -d ${DATABASE_NAME} -s "ALTER USER SET PASSWORD '${DATABASE_PASSWD}' USING OLD PASSWORD '${DATABASE_OLD_PASSWD}'";
    DEL_PASSWD;
}

SETUP(){

    if [ ! -d ${MONETDB_FARM_DIR} ]; then
        monetdbd create ${MONETDB_FARM_DIR};
        monetdbd set listenaddr=0.0.0.0 ${MONETDB_FARM_DIR};
        monetdbd start ${MONETDB_FARM_DIR};
        TOUCH_PASSWD ${DATABASE_USER} ${DATABASE_OLD_PASSWD};
        sleep 5;

        if [ ! -d ${MONETDB_DATABASE_LOCATION} ]; then
            monetdb create ${DATABASE_NAME} && monetdb set embedr=true ${DATABASE_NAME} && monetdb release \
                    ${DATABASE_NAME};

        else
           echo "Existing database found at ${MONETDB_DATABASE_LOCATION}"
        fi

        for i in {30..0}; do
            echo "Testing connection..." $i;
            mclient -d ${DATABASE_NAME} -s 'SELECT 1' &> /dev/null;
            if [ $? -ne 0 ]; then
                echo "Waiting for cdb to start...";
                sleep 1;
            else
                echo "MonetDB is running....";
                break;
            fi
        done

        if [ $i -eq 0 ]; then
            echo "MonetDB startup failed";
            exit 1;
        fi

        SET_PASSWORD;
        monetdb stop ${DATABASE_NAME};
        rm -rf .monetdb
        sleep 10;
        echo "Setup complete...";
    fi

}


if [ $1 == "monetdb" ]; then
    SETUP;
    envsubst < /opt/scripts/supervisord.conf.template > ${HOME}/supervisord.conf
    /usr/bin/supervisord -c ${HOME}/supervisord.conf
else
    exec $@
fi
