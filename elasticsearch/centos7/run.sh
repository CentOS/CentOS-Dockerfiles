#!/usr/bin/env bash

# Permissions
export USER_ID=$(id -u);
export GROUP_ID=$(id -g);
envsubst < /opt/scripts/passwd.template > /tmp/passwd;
export LD_PRELOAD=libnss_wrapper.so;
export NSS_WRAPPER_PASSWD=/tmp/passwd;
export NSS_WRAPPER_GROUP=/etc/group;
ELASTIC_CONFIG="/etc/elasticsearch/elasticsearch.yml";
ELASTIC_CONFIG_BAK="/etc/elasticsearch/elasticsearch.yml.bak";

rm -rf ${ELASTIC_CONFIG};
cp ${ELASTIC_CONFIG_BAK} ${ELASTIC_CONFIG};

cat >>${ELASTIC_CONFIG} <<EOF
network.host: 0.0.0.0
discovery.zen.minimum_master_nodes: 1
http.cors.enabled: true
http.cors.allow-origin: /http://localhost(:[0-9]+)?/
EOF

# Main Begins
if [ $1 == "elastic" ]; then

    exec /usr/share/elasticsearch/bin/elasticsearch;
else
    exec $@
fi
