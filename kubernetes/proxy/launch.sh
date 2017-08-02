#!/bin/bash

[ -f /etc/kubernetes/proxy ] && source /etc/kubernetes/proxy
[ -f /etc/kubernetes/config ] && source /etc/kubernetes/config

ARGS="$@ $KUBE_LOGTOSTDERR $KUBE_LOG_LEVEL $KUBE_MASTER $KUBE_PROXY_ARGS"

exec /usr/bin/kube-proxy $ARGS
