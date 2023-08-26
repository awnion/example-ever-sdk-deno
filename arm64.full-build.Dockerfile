# syntax=docker/dockerfile:1.5

ARG DENO_VERSION=1.36.2
ARG BIN_IMAGE=denoland/deno:ubuntu-${DENO_VERSION}

FROM --platform=$BUILDPLATFORM rust:1.72 as builder

RUN apt-get update -yq && apt-get install -yq git gzip cmake

WORKDIR /workdir
RUN \
  git clone https://github.com/tonlabs/ever-sdk-js.git . \
  && git checkout SDK-4838-deno-binding

WORKDIR /workdir/packages/lib-deno/build
RUN \
  --mount=type=cache,target=/usr/local/cargo/registry \
  --mount=type=cache,target=/usr/local/cargo/git \
  cargo run -r

RUN \
  --mount=type=cache,target=/usr/local/cargo/registry \
  --mount=type=cache,target=/usr/local/cargo/git \
  cargo install deno

RUN cp /workdir/packages/lib-deno/publish/eversdk_1_44_deno_addon_arm64-linux.gz .
RUN gzip -d eversdk_1_44_deno_addon_arm64-linux.gz
RUN mv eversdk_1_44_deno_addon_arm64-linux /usr/lib/eversdk.deno
# COPY --from=builder /workdir/packages/lib-deno/publish/eversdk_1_44_deno_addon_arm64-linux.gz .

FROM debian:bookworm
RUN apt-get update -yq && apt-get install -yq libssl3
COPY --from=builder --link /usr/local/cargo/bin/deno /usr/local/bin/deno
COPY --from=builder --link /usr/lib/eversdk.deno /usr/lib/eversdk.deno
WORKDIR /workdir
