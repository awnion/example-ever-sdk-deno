ARG DENO_VERSION=1.34.3
ARG BIN_IMAGE=denoland/deno:bin-${DENO_VERSION}


FROM ${BIN_IMAGE} AS bin


FROM ubuntu:22.04

RUN apt-get update -yq && apt-get install -yq wget

RUN useradd --uid 1993 --user-group deno \
  && mkdir /deno-dir/ \
  && chown deno:deno /deno-dir/

ENV DENO_DIR /deno-dir/
ENV DENO_INSTALL_ROOT /usr/local

ARG DENO_VERSION
ENV DENO_VERSION=${DENO_VERSION}
COPY --from=bin /deno /usr/bin/deno

WORKDIR /root/.tonlabs/binaries/1_43
RUN wget -O - https://binaries.tonlabs.io/eversdk_1_nodejs_addon_x64-linux.gz | gzip -d > eversdk.node
