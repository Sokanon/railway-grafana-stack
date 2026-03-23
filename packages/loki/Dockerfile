# Copy Loki binary from official image (which is distroless / has no shell)
FROM grafana/loki:latest AS loki-bin

FROM alpine:latest

# Install su-exec for privilege dropping
RUN apk add --no-cache su-exec ca-certificates

# Copy Loki binary from official image
COPY --from=loki-bin /usr/bin/loki /usr/bin/loki

# Copy custom config template and entrypoint
COPY packages/loki/loki-config.yaml /etc/loki/loki-config.template.yaml
COPY --chmod=755 packages/loki/entrypoint.sh /entrypoint.sh

# Create loki user
RUN addgroup -g 10001 loki && adduser -D -u 10001 -G loki loki

# Railway requires apps to listen on PORT; default to 3100 for Loki.
ENV PORT=3100

ENTRYPOINT ["/entrypoint.sh"]
