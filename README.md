> [!IMPORTANT]
> **此 repo 已不再維護。** 這個 image 已移到 [swaglive/docker-images](https://github.com/swaglive/docker-images/tree/master/docker-kubectl)，
> 由 GitHub Actions 推到 `asia-docker.pkg.dev/swag-2c052/swaglive/kubectl`，之後的改動請到 docker-images 開 PR。
> 這裡的 publish workflow 已移除，Docker Hub／ghcr.io 上的 `swaglive/kubectl` 不會再更新。（GENP-6287）

* [kubectl Releases](https://kubernetes.io/releases/)


## Usage

```
docker run -it --rm \
    -e KUBECONFIG_CA=$CLUSTER_CA_CERT_IN_BASE64 \
    -e KUBECONFIG_SERVER=$CLUSTER_ENDPOINT \
    -e KUBECONFIG_TOKEN=$SERVICE_ACCOUNT_TOKEN \
    swaglive/kubctl config view
```