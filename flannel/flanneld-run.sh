#!/bin/bash

# Create flannel.conf for docker service
echo "[Service]" > /etc/systemd/system/docker.service.d/$NAME.conf
echo "EnvironmentFile=-/run/$NAME/docker" >> /etc/systemd/system/docker.service.d/$NAME.conf

# Ensure this file doesn't already exist.
rm -f run/flannel/subnet.env

/usr/bin/flanneld &
child=$!

while test \! -e /run/flannel/subnet.env
do
    sleep 0.1
done

/usr/libexec/flannel/mk-docker-opts.sh -k DOCKER_NETWORK_OPTIONS -d /run/flannel/docker

wait $child
