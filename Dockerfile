FROM rust:slim AS base
  RUN apt-get update && \
      apt-get install musl musl-dev musl-tools && \
      useradd -m -U rust

FROM base as build
  USER rust
  WORKDIR /home/rust
  COPY --chown=rust:rust . .
  RUN rustup target add x86_64-unknown-linux-musl && \
      cargo install --target x86_64-unknown-linux-musl --path . && \
      strip /usr/local/cargo/bin/rust_hello

FROM scratch
  COPY --from=build /usr/local/cargo/bin/rust_hello /bin/server
  ENTRYPOINT ["/bin/server"]

