FROM alpine:latest AS base

RUN apk add --no-cache su-exec

# Copy Loki binary from official image
FROM grafana/loki:latest AS loki-bin

FROM alpine:latest

# Install su-exec for privilege dropping
RUN apk add --no-cache su-exec ca-certificates

# Copy Loki binary from official image
COPY --from=loki-bin /usr/bin/loki /usr/bin/loki

# Copy custom config and entrypoint
COPY packages/loki/loki-config.yaml /etc/loki/local-config.yaml
COPY --chmod=755 packages/loki/entrypoint.sh /entrypoint.sh

# Create loki user
RUN addgroup -g 10001 loki && adduser -D -u 10001 -G loki loki

ENTRYPOINT ["/entrypoint.sh"]
