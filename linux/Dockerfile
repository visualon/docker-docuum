
# renovate: datasource=github-releases depName=docuum lookupName=stepchowfun/docuum
ARG DOCUUM_VERSION=0.20.3

# renovate: datasource=github-releases depName=docker lookupName=moby/moby
ARG DOCKER_VERSION=20.10.11

FROM alpine:3.14@sha256:635f0aa53d99017b38d1a0aa5b2082f7812b03e3cdb299103fe77b5c8a07f1d2 as base

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

