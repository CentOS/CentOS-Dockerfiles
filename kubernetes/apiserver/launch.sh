#!/bin/bash

source /etc/kubernetes/apiserver
source /etc/kubernetes/config

export KUBE_LOGTOSTDERR
export KUBE_LOG_LEVEL
export KUBE_ETCD_SERVERS
export KUBE_API_ADDRESS
export KUBE_API_PORT
export KUBELET_PORT
export KUBE_ALLOW_PRIV
export KUBE_SERVICE_ADDRESSES
export KUBE_ADMISSION_CONTROL
export KUBE_API_ARG

exec /usr/bin/kube-apiserver \
  $KUBE_LOGTOSTDERR \
  $KUBE_LOG_LEVEL \
  $KUBE_ETCD_SERVERS \
  $KUBE_API_ADDRESS \
  $KUBE_API_PORT \
  $KUBELET_PORT \
  $KUBE_ALLOW_PRIV \
  $KUBE_SERVICE_ADDRESSES \
  $KUBE_ADMISSION_CONTROL \
  $KUBE_API_ARGS \
  $@
