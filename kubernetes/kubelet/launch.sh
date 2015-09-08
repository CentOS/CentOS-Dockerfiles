#!/bin/bash

source /etc/kubernetes/kubelet
source /etc/kubernetes/config

export KUBE_LOGTOSTDERR
export KUBE_LOG_LEVEL
export KUBELET_API_SERVER
export KUBELET_ADDRESS
export KUBELET_PORT
export KUBELET_HOSTNAME
export KUBE_ALLOW_PRIV
export KUBELET_ARGS

exec /usr/bin/kubelet \
  $KUBE_LOGTOSTDERR \
  $KUBE_LOG_LEVEL \
  $KUBELET_API_SERVER \
  $KUBELET_ADDRESS \
  $KUBELET_PORT \
  $KUBELET_HOSTNAME \
  $KUBE_ALLOW_PRIV \
  $KUBELET_ARGS \
  --containerized \
  $@
