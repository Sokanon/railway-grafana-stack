#!/bin/sh
set -e

# Fix volume permissions (Railway volumes mount as root)
# Grafana runs as UID 472
if [ -d /var/lib/grafana ] && [ "$(stat -c '%u' /var/lib/grafana)" = "0" ]; then
  chown -R 472:0 /var/lib/grafana
fi

exec su-exec grafana /run.sh
