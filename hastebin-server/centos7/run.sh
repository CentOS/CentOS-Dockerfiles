#!/usr/bin/env bash

HASTE_CONFIG_TEMPLATE="/opt/scripts/config.js.template"
HASTE_CONFIG="/opt/hastebin-server/config.js"

CONFIG_HASTEBIN(){

    export KEY_LENGTH=${KEY_LENGTH:-10};
    export MAX_LENGTH=${MAX_LENGTH:-400000};
    export STATIC_MAX_AGE=${STATIC_MAX_AGE:-86400}
    export KEY_TYPE=${KEY_TYPE:-phonetic};
    export DATABASE_URL=${DATABASE_URL:-""}
    export STORAGE_TYPE=${STORAGE_TYPE:-"file"}
    export STORAGE_FILE_PATH=${STORAGE_FILE_PATH:-"/opt/data"}
    export STORAGE_HOST=${STORAGE_HOST:="0.0.0.0"}
    export STORAGE_PORT=${STORAGE_PORT:-6379}
    export STORAGE_DB=${STORAGE_DB:-2}
    export STORAGE_EXPIRE=${STORAGE_EXPIRE:-2592000}

    envsubst < ${HASTE_CONFIG_TEMPLATE} > ${HASTE_CONFIG}

}


if [ $1 == "hastebin" ]; then
    CONFIG_HASTEBIN;
    exec npm start;
else
    exec $@
fi