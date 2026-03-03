FROM prom/prometheus:latest

USER root

# Copy config as template (env vars substituted at runtime)
COPY packages/prometheus/prometheus.yml /etc/prometheus/prometheus.template.yml
COPY --chmod=755 packages/prometheus/entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
