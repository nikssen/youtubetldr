FROM debian:bookworm-slim

# Download the official x86_64-linux release binary directly
ARG TLDR_VERSION=1.6.0
RUN apt-get update && apt-get install -y wget ca-certificates && \
    wget "https://github.com/Milkshiift/YouTubeTLDR/releases/download/v${TLDR_VERSION}/YouTubeTLDR-x86_64-linux" -O /usr/local/bin/YouTubeTLDR && \
    chmod +x /usr/local/bin/YouTubeTLDR && \
    apt-get purge -y --auto-remove wget && rm -rf /var/lib/apt/lists/*

# Copy static files from upstream release (or fetch them)
COPY static /app/static
WORKDIR /app
EXPOSE 8000
ENV TLDR_IP=0.0.0.0
ENV TLDR_PORT=8000
ENTRYPOINT ["/usr/local/bin/YouTubeTLDR"]
