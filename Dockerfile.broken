FROM rustlang/rust:nightly-alpine AS builder

ARG TLDR_VERSION

RUN apk add --no-cache openssl-dev pkgconfig build-base git

WORKDIR /YouTubeTLDR

# Clone the upstream repo at the release tag
RUN git clone --depth 1 --branch "v${TLDR_VERSION}" https://github.com/Milkshiift/YouTubeTLDR.git .

# Build release with rustls-tls (same as upstream Dockerfile)
RUN cargo build --release --no-default-features --features rustls-tls

FROM alpine:3.20

RUN apk add --no-cache openssl ca-certificates

COPY --from=builder /YouTubeTLDR/target/release/YouTubeTLDR /usr/local/bin/YouTubeTLDR
COPY --from=builder /YouTubeTLDR/static /app/static

WORKDIR /app
EXPOSE 8000
ENV TLDR_IP=0.0.0.0
ENV TLDR_PORT=8000

ENTRYPOINT ["/usr/local/bin/YouTubeTLDR"]
