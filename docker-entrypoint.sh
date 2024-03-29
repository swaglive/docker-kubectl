#!/bin/sh
set -e

kubectl config set contexts.default.cluster default
kubectl config set contexts.default.user default
kubectl config set contexts.default.namespace default
kubectl config set current-context default

[ ! -z "$KUBECONFIG_NAMESPACE" ] && kubectl config set contexts.default.namespace $KUBECONFIG_NAMESPACE
[ ! -z "$KUBECONFIG_CA" ] && kubectl config set clusters.default.certificate-authority-data $KUBECONFIG_CA
[ ! -z "$KUBECONFIG_SERVER" ] && kubectl config set clusters.default.server $KUBECONFIG_SERVER
[ ! -z "$KUBECONFIG_TOKEN" ] && kubectl config set users.default.token $KUBECONFIG_TOKEN

exec "$@"
