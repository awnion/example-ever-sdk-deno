# syntax=docker/dockerfile:1.5


FROM rust:1.72 as builder
RUN apt-get update -yq && apt-get install -yq git gzip cmake


FROM builder as sdk
WORKDIR /workdir
RUN \
  git clone https://github.com/tonlabs/ever-sdk-js.git . \
  && git checkout dff44be
WORKDIR /workdir/packages/lib-deno/build
RUN \
  --mount=type=cache,target=/usr/local/cargo/registry \
  --mount=type=cache,target=/usr/local/cargo/git \
  cargo run -r

WORKDIR /workdir/packages/lib-deno
RUN mv eversdk.deno /usr/lib/eversdk.deno


FROM builder as deno
RUN \
  --mount=type=cache,target=/usr/local/cargo/registry \
  --mount=type=cache,target=/usr/local/cargo/git \
  cargo install deno


FROM debian:bookworm
RUN apt-get update -yq && apt-get install -yq libssl3
COPY --link --from=deno /usr/local/cargo/bin/deno /usr/local/bin/deno
COPY --link --from=sdk /usr/lib/eversdk.deno /usr/lib/eversdk.deno
WORKDIR /workdir
