FROM alpine:3.20

ARG TLDR_VERSION
ARG TLDR_URL

RUN apk add --no-cache ca-certificates curl

RUN curl -fsSL "$TLDR_URL" -o /usr/local/bin/YouTubeTLDR \
 && chmod +x /usr/local/bin/YouTubeTLDR

EXPOSE 8000
ENV TLDR_IP=0.0.0.0
ENV TLDR_PORT=8000

ENTRYPOINT ["/usr/local/bin/YouTubeTLDR"]
