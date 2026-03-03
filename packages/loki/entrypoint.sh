#!/bin/sh
set -e

# Fix volume permissions (Railway volumes mount as root)
if [ -d /loki ] && [ "$(stat -c '%u' /loki)" = "0" ]; then
  chown -R 10001:10001 /loki
fi

exec su-exec loki /usr/bin/loki -config.file=/etc/loki/local-config.yaml
