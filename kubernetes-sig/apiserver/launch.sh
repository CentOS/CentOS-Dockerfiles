#!/bin/bash

source /etc/kubernetes/apiserver
source /etc/kubernetes/config

ARGS=$(echo "$@ $KUBE_LOGTOSTDERR $KUBE_LOG_LEVEL $KUBE_ETCD_SERVERS $KUBE_API_ADDRESS $KUBE_API_PORT $KUBELET_PORT $KUBE_ALLOW_PRIV $KUBE_SERVICE_ADDRESSES $KUBE_ADMISSION_CONTROL $KUBE_API_ARGS" | xargs -n1 | sort -u -t = -k 1,1 | xargs)

exec /usr/bin/kube-apiserver $ARGS
