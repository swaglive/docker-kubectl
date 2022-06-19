![Docker](https://github.com/swaglive/docker-kubectl/workflows/Docker/badge.svg)

* [kubectl Releases](https://kubernetes.io/releases/)


## Usage

```
docker run -it --rm \
    -e KUBECONFIG_CA=$CLUSTER_CA_CERT_IN_BASE64 \
    -e KUBECONFIG_SERVER=$CLUSTER_ENDPOINT \
    -e KUBECONFIG_TOKEN=$SERVICE_ACCOUNT_TOKEN \
    swaglive/kubctl config view
```