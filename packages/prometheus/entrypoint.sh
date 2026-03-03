#!/bin/sh
set -e

# Fix volume permissions (Railway volumes mount as root)
# Prometheus runs as nobody (UID 65534)
if [ -d /prometheus ] && [ "$(stat -c '%u' /prometheus)" = "0" ]; then
  chown -R 65534:65534 /prometheus
fi

# Replace placeholder with actual Grafana host from Railway private networking
sed "s|\${GRAFANA_HOST}|${GRAFANA_HOST:-localhost}|g" \
  /etc/prometheus/prometheus.template.yml > /tmp/prometheus.yml

exec su-exec nobody /bin/prometheus \
  --config.file=/tmp/prometheus.yml \
  --storage.tsdb.path=/prometheus \
  --web.console.libraries=/usr/share/prometheus/console_libraries \
  --web.console.templates=/usr/share/prometheus/consoles \
  --web.enable-lifecycle
