#!/bin/sh
set -e

# Railway injects PORT and uses it for healthchecks.
LISTEN_PORT="${PORT:-9090}"

# Fix volume permissions (Railway volumes mount as root)
# Prometheus runs as nobody (UID 65534)
if [ -d /prometheus ]; then
  chown -R 65534:65534 /prometheus 2>/dev/null || true
fi

# Replace placeholders with actual values from Railway environment
sed -e "s|\${GRAFANA_HOST}|${GRAFANA_HOST:-localhost}|g" \
    -e "s|\${GRAFANA_PORT}|${GRAFANA_PORT:-3000}|g" \
    -e "s|\${LISTEN_PORT}|${LISTEN_PORT}|g" \
  /etc/prometheus/prometheus.template.yml > /tmp/prometheus.yml

exec /bin/prometheus \
  --config.file=/tmp/prometheus.yml \
  --storage.tsdb.path=/prometheus \
  --web.listen-address="0.0.0.0:${LISTEN_PORT}" \
  --web.console.libraries=/usr/share/prometheus/console_libraries \
  --web.console.templates=/usr/share/prometheus/consoles \
  --web.enable-lifecycle
