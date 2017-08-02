#!/bin/bash

[ -f /etc/kubernetes/apiserver ] && source /etc/kubernetes/apiserver
[ -f /etc/kubernetes/config ] && source /etc/kubernetes/config

ARGS="$@ $KUBE_LOGTOSTDERR $KUBE_LOG_LEVEL $KUBE_ETCD_SERVERS $KUBE_API_ADDRESS $KUBE_API_PORT $KUBELET_PORT $KUBE_ALLOW_PRIV $KUBE_SERVICE_ADDRESSES $KUBE_ADMISSION_CONTROL $KUBE_API_ARGS"

exec /usr/bin/kube-apiserver $ARGS
