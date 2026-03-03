FROM prom/prometheus:latest

USER root

# Install su-exec for dropping privileges after permission fix
RUN apk add --no-cache su-exec

# Copy config as template (env vars substituted at runtime)
COPY packages/prometheus/prometheus.yml /etc/prometheus/prometheus.template.yml
COPY --chmod=755 packages/prometheus/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
