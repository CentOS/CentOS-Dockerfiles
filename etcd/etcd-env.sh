#!/bin/sh

ipaddress=$(hostname -I | cut -f1 -d' ')
if test x$NAME == x; then
    NAME=$HOSTNAME
fi
export ETCD_NAME=${ETCD_NAME:-$HOSTNAME}
export ETCD_DATA_DIR=/var/lib/etcd/${NAME}.etcd
export ETCD_ADVERTISE_CLIENT_URLS=${ETCD_ADVERTISE_CLIENT_URLS:-http://${ipaddress}:2379,http://${ipaddress}:4001}
export ETCD_LISTEN_CLIENT_URLS=${ETCD_LISTEN_CLIENT_URLS:-http://0.0.0.0:2379,http://0.0.0.0:4001}
export ETCD_INITIAL_ADVERTISE_PEER_URLS=${ETCD_INITIAL_ADVERTISE_PEER_URLS:-http://${ipaddress}:2380,http://${ipaddress}:7001}
export ETCD_LISTEN_PEER_URLS=${ETCD_LISTEN_PEER_URLS:-http://0.0.0.0:2380,http://0.0.0.0:7001}
export ETCD_INITIAL_CLUSTER=${ETCD_INITIAL_CLUSTER:-$HOSTNAME=http://${ipaddress}:2380,$HOSTNAME=http://${ipaddress}:7001}

# Execute the commands passed to this script
exec "$@"
