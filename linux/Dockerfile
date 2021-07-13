# renovate: datasource=github-releases depName=docuum lookupName=stepchowfun/docuum
ARG DOCUUM_VERSION=0.19.0

# renovate: datasource=docker depName=docker versioning=docker
ARG DOCKER_VERSION=20.10.6

FROM alpine:3.14@sha256:234cb88d3020898631af0ccbbcca9a66ae7306ecd30c9720690858c1b007d2a0 as base

#=================
# build
#=================
FROM base as build

RUN apk add --no-cache curl

RUN mkdir /build

ARG DOCKER_VERSION
RUN set -ex; \
  curl -sSfLo file.tgz https://download.docker.com/linux/static/stable/x86_64/docker-${DOCKER_VERSION}.tgz; \
  tar xzvf file.tgz --strip 1 -C /build docker/docker; \
  /build/docker --version

ARG DOCUUM_VERSION
RUN set -ex; \
  curl -sSfLo /build/docuum https://github.com/stepchowfun/docuum/releases/download/v${DOCUUM_VERSION}/docuum-x86_64-unknown-linux-musl; \
  chmod +x /build/docuum; \
  /build/docuum --version


#=================
# final
#=================
FROM base as final

RUN apk add --no-cache ca-certificates tzdata dumb-init

LABEL maintainer="Michael Kriese <michael.kriese@visualon.de>" \
    org.opencontainers.image.authors="Michael Kriese <michael.kriese@visualon.de>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.source="https://github.com/visualon/docker-docuum" \
    org.opencontainers.image.url="https://github.com/visualon/docker-docuum"

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/bin/docuum"]

ARG DOCUUM_VERSION
LABEL org.opencontainers.image.version="${DOCUUM_VERSION}"

COPY --from=build /build/ /bin/

