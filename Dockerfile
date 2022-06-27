ARG         base=alpine:3.16

FROM        ${base} as kubectl

ARG         version=1.24.1
ARG         url=https://dl.k8s.io/release/v${version}/bin/linux/amd64/kubectl

RUN         apk add --no-cache --virtual .build-deps \
                curl && \
            curl -LO ${url} && \
            echo "$(curl -L ${url}.sha256)  kubectl" | sha256sum -c && \
            apk del .build-deps && \
            install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

###

FROM        ${base} as s6

ARG         s6_version=3.1.0.1

RUN         apk add --no-cache --virtual .build-deps \
                curl && \
            curl -L https://github.com/just-containers/s6-overlay/releases/download/v${s6_version}/s6-overlay-noarch.tar.xz | tar -Jxvp -C /usr/local/bin && \
            curl -L https://github.com/just-containers/s6-overlay/releases/download/v${s6_version}/s6-overlay-x86_64.tar.xz | tar -Jxvp -C /usr/local/bin && \
            apk del .build-deps

###

FROM        ${base}

ENV         S6_BEHAVIOUR_IF_STAGE2_FAILS=2
ENV         S6_KEEP_ENV=1
ENV         KUBECONFIG=/.kube/config

ENTRYPOINT  ["/init", "kubectl"]
CMD         ["version", "--client"]

RUN         apk add --no-cache --virtual .run-deps \
                ca-certificates \
                bash

COPY        --from=s6 /usr/local/bin /
COPY        --from=kubectl /usr/local/bin/kubectl /usr/local/bin/kubectl
COPY        --chown=root:root rootfs/cont-init.d /etc/cont-init.d
