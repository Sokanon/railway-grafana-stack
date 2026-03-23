#!/bin/sh
set -e

# Railway injects PORT and uses it for healthchecks.
LISTEN_PORT="${PORT:-3100}"

# Substitute the listen port into the config template
sed "s|\${LISTEN_PORT}|${LISTEN_PORT}|g" \
  /etc/loki/loki-config.template.yaml > /tmp/loki-config.yaml

# Fix volume permissions (Railway volumes mount as root)
if [ -d /loki ]; then
  chown -R 10001:10001 /loki 2>/dev/null || true
fi

exec su-exec loki /usr/bin/loki -config.file=/tmp/loki-config.yaml
