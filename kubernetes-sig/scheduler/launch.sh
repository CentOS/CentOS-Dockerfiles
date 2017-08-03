#!/bin/bash

[ -f /etc/kubernetes/scheduler ] && source /etc/kubernetes/scheduler
[ -f /etc/kubernetes/config ] && source /etc/kubernetes/config

ARGS="$@ $KUBE_LOGTOSTDERR $KUBE_LOG_LEVEL $KUBE_MASTER $KUBE_SCHEDULER_ARGS"

exec /usr/bin/kube-scheduler $ARGS
