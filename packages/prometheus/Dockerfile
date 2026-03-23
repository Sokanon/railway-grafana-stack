FROM prom/prometheus:latest

USER root

# Copy config as template (env vars substituted at runtime)
COPY packages/prometheus/prometheus.yml /etc/prometheus/prometheus.template.yml
COPY --chmod=755 packages/prometheus/entrypoint.sh /entrypoint.sh

# Railway requires apps to listen on PORT; default to 9090 for Prometheus.
ENV PORT=9090
ENV GRAFANA_HOST=localhost
ENV GRAFANA_PORT=3000

ENTRYPOINT ["/entrypoint.sh"]
