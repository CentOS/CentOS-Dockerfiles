#!/bin/bash

source /etc/kubernetes/kubelet
source /etc/kubernetes/config

ARGS=$(echo "$@ $KUBE_LOGTOSTDERR $KUBE_LOG_LEVEL $KUBELET_API_SERVER $KUBELET_ADDRESS $KUBELET_PORT $KUBELET_HOSTNAME $KUBE_ALLOW_PRIV $KUBELET_ARGS" | xargs -n1 | sort -u -t = -k 1,1 | xargs)

exec /usr/bin/kubelet $ARGS --containerized
