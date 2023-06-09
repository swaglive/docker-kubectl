ARG         base=alpine:3.18

FROM        ${base} as kubectl

ARG         version=
ARG         url=https://dl.k8s.io/release/v${version}/bin/linux/amd64/kubectl

RUN         apk add --no-cache --virtual .build-deps \
                curl && \
            curl -LO ${url} && \
            echo "$(curl -L ${url}.sha256)  kubectl" | sha256sum -c && \
            apk del .build-deps && \
            install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

###

FROM        ${base}

ENV         KUBECONFIG=/.kube/config

ENTRYPOINT  ["tini", "--", "/docker-entrypoint.sh", "kubectl"]
CMD         ["version", "--client"]

RUN         apk add --no-cache --virtual .run-deps \
                ca-certificates \
                bash \
                tini

COPY        --from=kubectl /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY        docker-entrypoint.sh .