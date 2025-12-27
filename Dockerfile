FROM debian:bookworm-slim

ARG TLDR_VERSION
ARG TLDR_URL

RUN apt-get update \
 && apt-get install -y --no-install-recommends ca-certificates curl \
 && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL "$TLDR_URL" -o /usr/local/bin/YouTubeTLDR \
 && chmod +x /usr/local/bin/YouTubeTLDR

EXPOSE 8000
ENV TLDR_IP=0.0.0.0
ENV TLDR_PORT=8000

ENTRYPOINT ["/usr/local/bin/YouTubeTLDR"]

