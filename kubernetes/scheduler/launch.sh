#!/bin/bash

source /etc/kubernetes/scheduler
source /etc/kubernetes/config

export KUBE_LOGTOSTDERR
export KUBE_LOG_LEVEL
export KUBE_MASTER
export KUBE_SCHEDULER_ARGS

exec /usr/bin/kube-scheduler \
  $KUBE_LOGTOSTDERR \
  $KUBE_LOG_LEVEL \
  $KUBE_MASTER \
  $KUBE_SCHEDULER_ARGS \
  $@
