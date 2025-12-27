FROM rustlang/rust:nightly-alpine AS builder

ARG TLDR_VERSION

RUN apk add --no-cache build-base
RUN rustup target add x86_64-unknown-linux-musl

WORKDIR /src
RUN apk add --no-cache git
RUN git clone --depth 1 --branch "v${TLDR_VERSION}" https://github.com/Milkshiift/YouTubeTLDR.git .

RUN cargo build --release \
  --target x86_64-unknown-linux-musl \
  --no-default-features --features rustls-tls

FROM alpine:3.20
RUN apk add --no-cache ca-certificates
COPY --from=builder /src/target/x86_64-unknown-linux-musl/release/YouTubeTLDR /usr/local/bin/YouTubeTLDR
COPY --from=builder /src/static /app/static
WORKDIR /app
EXPOSE 8000
ENV TLDR_IP=0.0.0.0
ENV TLDR_PORT=8000
ENTRYPOINT ["/usr/local/bin/YouTubeTLDR"]
