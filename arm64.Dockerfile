# syntax=docker/dockerfile:1.5

ARG DENO_VERSION=1.36.1
ARG BIN_IMAGE=denoland/deno:ubuntu-${DENO_VERSION}

FROM ${BIN_IMAGE} AS bin


RUN apt-get update -yq && apt-get install -yq wget


WORKDIR /root/.tonlabs/binaries/1_44
RUN wget -O - https://binaries.tonlabs.io/eversdk_1_nodejs_addon_arm64-darwin.gz | gzip -d > eversdk.node

WORKDIR /workdir
