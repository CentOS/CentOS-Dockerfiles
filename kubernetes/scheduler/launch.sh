#!/bin/bash

source /etc/kubernetes/scheduler
source /etc/kubernetes/config

ARGS=$(echo "$@ $KUBE_LOGTOSTDERR $KUBE_LOG_LEVEL $KUBE_MASTER $KUBE_SCHEDULER_ARGS" | xargs -n1 | sort -u -t = -k 1,1 | xargs)

exec /usr/bin/kube-scheduler $ARGS
