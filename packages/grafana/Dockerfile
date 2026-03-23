FROM grafana/grafana:latest

USER root

# Install su-exec for dropping privileges after permission fix
RUN apk add --no-cache su-exec

# Copy provisioning configs for datasources
COPY packages/grafana/provisioning/datasources/datasources.yaml /etc/grafana/provisioning/datasources/datasources.yaml

# Copy entrypoint
COPY --chmod=755 packages/grafana/entrypoint.sh /entrypoint.sh

# Railway requires apps to listen on PORT; Grafana uses GF_SERVER_HTTP_PORT.
# Default to 3000 -- the entrypoint syncs GF_SERVER_HTTP_PORT from PORT at runtime.
ENV PORT=3000
ENV GF_SERVER_HTTP_PORT=3000
ENV GF_SERVER_HTTP_ADDR=0.0.0.0
ENV GF_SECURITY_ADMIN_USER=admin

# Datasource connection defaults (overridden by Railway env vars)
ENV PROMETHEUS_HOST=localhost
ENV PROMETHEUS_PORT=9090
ENV LOKI_HOST=localhost
ENV LOKI_PORT=3100

ENTRYPOINT ["/entrypoint.sh"]
