# Grafana + Prometheus + Loki Monitoring Stack

One-click deploy of a full observability stack on Railway. Includes [Grafana](https://grafana.com/) for dashboards, [Prometheus](https://prometheus.io/) for metrics collection, and [Loki](https://grafana.com/oss/loki/) for log aggregation.

[![Deploy on Railway](https://railway.com/button.svg)](https://railway.com/template/TEMPLATE_CODE)

## Services Included

- **Grafana** -- Visualization and dashboarding with pre-configured Prometheus and Loki datasources
- **Prometheus** -- Metrics collection and time-series database with self-monitoring and Grafana scrape targets
- **Loki** -- Log aggregation system optimized for storing and querying logs from your services

## Architecture

All three services communicate over Railway's private network. Grafana queries Prometheus and Loki for data. Prometheus scrapes metrics from itself and Grafana by default.

```
Grafana (port 3000) --queries--> Prometheus (port 9090)
Grafana (port 3000) --queries--> Loki (port 3100)
Prometheus (port 9090) --scrapes--> Grafana (port 3000)
Your apps --push logs--> Loki (port 3100)
```

## Environment Variables

### Grafana

| Variable | Description | Default |
|----------|-------------|---------|
| `PORT` | Port Grafana listens on (Railway healthcheck port) | `3000` |
| `GF_SECURITY_ADMIN_PASSWORD` | Admin login password | Auto-generated |
| `GF_SECURITY_ADMIN_USER` | Admin username | `admin` |
| `PROMETHEUS_HOST` | Prometheus private domain (auto-wired) | `${{Prometheus.RAILWAY_PRIVATE_DOMAIN}}` |
| `PROMETHEUS_PORT` | Prometheus listen port | `9090` |
| `LOKI_HOST` | Loki private domain (auto-wired) | `${{Loki.RAILWAY_PRIVATE_DOMAIN}}` |
| `LOKI_PORT` | Loki listen port | `3100` |

### Prometheus

| Variable | Description | Default |
|----------|-------------|---------|
| `PORT` | Port Prometheus listens on (Railway healthcheck port) | `9090` |
| `GRAFANA_HOST` | Grafana private domain for scraping (auto-wired) | `${{Grafana.RAILWAY_PRIVATE_DOMAIN}}` |
| `GRAFANA_PORT` | Grafana listen port for scraping | `3000` |

### Loki

| Variable | Description | Default |
|----------|-------------|---------|
| `PORT` | Port Loki listens on (Railway healthcheck port) | `3100` |

## Post-Deployment

1. Open the Grafana public URL from your Railway dashboard
2. Log in with the admin credentials (username: `admin`, password: from `GF_SECURITY_ADMIN_PASSWORD`)
3. Prometheus and Loki datasources are pre-configured and ready to use
4. Import dashboards or create your own

## Adding Scrape Targets to Prometheus

To monitor your own Railway services, fork this repo and add targets to `packages/prometheus/prometheus.yml`:

```yaml
scrape_configs:
  - job_name: "my-app"
    static_configs:
      - targets: ["your-service.railway.internal:8080"]
```

Your service must expose a `/metrics` endpoint in Prometheus format.

## Sending Logs to Loki

Push logs to Loki from your services using the Loki push API:

```
POST http://${{Loki.RAILWAY_PRIVATE_DOMAIN}}:3100/loki/api/v1/push
```

Or use [Grafana Alloy](https://grafana.com/docs/alloy/) / [Promtail](https://grafana.com/docs/loki/latest/send-data/promtail/) as a log shipper.

## Volumes

| Service | Mount Path | Purpose |
|---------|------------|---------|
| Grafana | `/var/lib/grafana` | Dashboards, users, preferences |
| Prometheus | `/prometheus` | Time-series metrics data |
| Loki | `/loki` | Log chunks and index data |
