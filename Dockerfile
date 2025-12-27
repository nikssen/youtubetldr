FROM debian:bookworm-slim

ARG TLDR_VERSION=1.6.0

RUN apt-get update && apt-get install -y wget ca-certificates curl && \
    # Download binary
    wget "https://github.com/Milkshiift/YouTubeTLDR/releases/download/v${TLDR_VERSION}/YouTubeTLDR-x86_64-linux" -O /usr/local/bin/YouTubeTLDR && \
    chmod +x /usr/local/bin/YouTubeTLDR && \
    # Download static files (assumes they publish a zip or individual files)
    mkdir -p /app/static && \
    cd /app/static && \
    wget -r -np -nH --cut-dirs=3 -R "index.html*" "https://github.com/Milkshiift/YouTubeTLDR/tree/v${TLDR_VERSION}/static" || true && \
    apt-get purge -y --auto-remove wget curl && rm -rf /var/lib/apt/lists/*

WORKDIR /app
EXPOSE 8000
ENV TLDR_IP=0.0.0.0
ENV TLDR_PORT=8000
ENTRYPOINT ["/usr/local/bin/YouTubeTLDR"]
