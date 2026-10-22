
# renovate: datasource=github-releases depName=docuum packageName=stepchowfun/docuum
ARG DOCUUM_VERSION=0.27.1

# renovate: datasource=github-releases depName=docker packageName=moby/moby
ARG DOCKER_VERSION=28.5.2

FROM alpine:3.24@sha256:71e9b7bae160ba167fa17414401b94cbcdaf3c32feeab9298bd794a2a0614c35 as base

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

