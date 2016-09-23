#!/bin/bash

source /etc/kubernetes/controller-manager
source /etc/kubernetes/config

ARGS=$(echo "$@ $KUBE_LOGTOSTDERR $KUBE_LOG_LEVEL $KUBE_MASTER $KUBE_CONTROLLER_MANAGER_ARGS" | xargs -n1 | sort -u -t = -k 1,1 | xargs)

exec /usr/bin/kube-controller-manager $ARGS
