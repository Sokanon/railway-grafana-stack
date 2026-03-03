FROM grafana/loki:latest

USER root

# Install su-exec for dropping privileges after permission fix
RUN apk add --no-cache su-exec

# Copy custom config and entrypoint
COPY packages/loki/loki-config.yaml /etc/loki/local-config.yaml
COPY --chmod=755 packages/loki/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
