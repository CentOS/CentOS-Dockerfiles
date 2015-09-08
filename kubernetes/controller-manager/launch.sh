#!/bin/bash

source /etc/kubernetes/controller-manager
source /etc/kubernetes/config

export KUBE_LOGTOSTDERR
export KUBE_LOG_LEVEL
export KUBE_MASTER
export KUBE_CONTROLLER_MANAGER_ARGS

exec /usr/bin/kube-controller-manager \
  $KUBE_LOGTOSTDERR \
  $KUBE_LOG_LEVEL \
  $KUBE_MASTER \
  $KUBE_CONTROLLER_MANAGER_ARGS \
  $@
