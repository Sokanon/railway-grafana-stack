#!/bin/sh
set -e

# Railway injects PORT and uses it for healthchecks.
# Sync Grafana's listen port to match.
export GF_SERVER_HTTP_PORT="${PORT:-3000}"

# Fix volume permissions (Railway volumes mount as root)
# Grafana runs as UID 472
if [ -d /var/lib/grafana ]; then
  chown -R 472:0 /var/lib/grafana 2>/dev/null || true
fi

exec su-exec grafana /run.sh
