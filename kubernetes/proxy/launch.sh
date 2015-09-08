#!/bin/bash

source /etc/kubernetes/proxy
source /etc/kubernetes/config

export KUBE_LOGTOSTDERR
export KUBE_LOG_LEVEL
export KUBE_MASTER
export KUBE_PROXY_ARGS

exec /usr/bin/kube-proxy \
  $KUBE_LOGTOSTDERR \
  $KUBE_LOG_LEVEL \
  $KUBE_MASTER \
  $KUBE_PROXY_ARGS \
  $@
