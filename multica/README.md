# Multica Helm Chart

A Helm chart for deploying [Multica](https://multica.ai) - an open-source managed AI Agents platform.

## Prerequisites

- Kubernetes 1.24+
- Helm 3.12+
- PostgreSQL database with `pgvector` extension (see [Database Options](#database-options))

## Important Notice: PostgreSQL

**⚠️ Bitnami PostgreSQL is deprecated and no longer receives security updates.**

This chart **defaults to external PostgreSQL** configuration. You must provide your own database.

### Database Options

| Option | Description | Recommended For |
|--------|-------------|---------------|
| **Managed PostgreSQL** | AWS RDS, Google Cloud SQL, Azure Database | Production |
| **Serverless PostgreSQL** | Supabase, Neon | Development, small production |
| **Self-Managed** | CloudNativePG operator, Zalando operator, Percona | Advanced users |

## Installation

### Quick Start (External PostgreSQL Required)

```bash
# Add the repository and login to GHCR
helm registry login ghcr.io -u YOUR_GITHUB_USERNAME

# Install with external PostgreSQL
helm install multica oci://ghcr.io/timoa-ai/charts/multica \
  --namespace multica --create-namespace \
  --set externalPostgresql.host=YOUR_DB_HOST \
  --set externalPostgresql.port=5432 \
  --set externalPostgresql.database=multica \
  --set externalPostgresql.username=YOUR_DB_USER \
  --set externalPostgresql.password=YOUR_DB_PASSWORD \
  --set secrets.jwt.value=YOUR_JWT_SECRET \
  --set config.frontendOrigin=https://multica.yourdomain.com
```

### Using Existing Secrets (Recommended for Production)

```bash
# Create secrets manually
kubectl create namespace multica

kubectl create secret generic multica-db-secret \
  --namespace multica \
  --from-literal=password=YOUR_DB_PASSWORD

kubectl create secret generic multica-jwt-secret \
  --namespace multica \
  --from-literal=jwt-secret=YOUR_JWT_SECRET

# Install chart referencing existing secrets
helm install multica oci://ghcr.io/timoa-ai/charts/multica \
  --namespace multica \
  --set externalPostgresql.host=YOUR_DB_HOST \
  --set externalPostgresql.username=YOUR_DB_USER \
  --set externalPostgresql.existingSecret=multica-db-secret \
  --set secrets.jwt.existingSecret=multica-jwt-secret
```

### With Ingress (Production Setup)

```bash
helm install multica oci://ghcr.io/timoa-ai/charts/multica \
  --namespace multica --create-namespace \
  --set externalPostgresql.host=YOUR_DB_HOST \
  --set externalPostgresql.existingSecret=multica-db-secret \
  --set frontend.ingress.enabled=true \
  --set frontend.ingress.className=nginx \
  --set 'frontend.ingress.hosts[0].host=multica.yourdomain.com' \
  --set 'frontend.ingress.hosts[0].paths[0].path=/' \
  --set 'frontend.ingress.hosts[0].paths[0].pathType=Prefix'
```

## Configuration

### Required Values

| Parameter | Description | Default |
|-----------|-------------|---------|
| `externalPostgresql.host` | PostgreSQL hostname | `nil` |
| `externalPostgresql.username` | PostgreSQL username | `nil` |
| `externalPostgresql.password` or `externalPostgresql.existingSecret` | PostgreSQL credentials | `nil` |
| `secrets.jwt.value` or `secrets.jwt.existingSecret` | JWT signing secret | `nil` |
| `config.frontendOrigin` | Frontend URL for CORS | `http://localhost:3000` |
| `config.logLevel` | Log level (debug, info, warn, error) | `info` |
| `config.databasePool.maxConns` | Maximum database connections per pod | `25` (built-in) |
| `config.databasePool.minConns` | Minimum database connections per pod | `5` (built-in) |

### Optional: Database Pool Tuning

For high-traffic deployments, tune the database connection pool:

```yaml
config:
  databasePool:
    maxConns: "50"
    minConns: "10"
```

### Optional: Google OAuth

```yaml
config:
  google:
    clientId: "your-google-client-id"
    redirectUri: "https://multica.yourdomain.com/auth/callback"

secrets:
  google:
    existingSecret: "multica-google-secret"
    existingSecretKey: "google-client-secret"
```

### Optional: Resend Email

```yaml
config:
  resend:
    fromEmail: "noreply@multica.yourdomain.com"

secrets:
  resend:
    value: "re_xxxxxxxx"
    # or use existingSecret
    # existingSecret: "multica-resend-secret"
    # existingSecretKey: "resend-api-key"
```

### Optional: S3 / CloudFront for File Storage

```yaml
config:
  s3:
    bucket: "my-multica-bucket"
    region: "us-west-2"
  cloudfront:
    domain: "cdn.yourdomain.com"
    keyPairId: "your-key-pair-id"

secrets:
  cloudfront:
    value: "-----BEGIN PRIVATE KEY-----\n..."
    # or use existingSecret
    # existingSecret: "multica-cloudfront-secret"
    # existingSecretKey: "cloudfront-private-key"
```

## Upgrading

```bash
# Upgrade to latest version
helm upgrade multica oci://ghcr.io/timoa-ai/charts/multica --namespace multica

# Upgrade with new values
helm upgrade multica oci://ghcr.io/timoa-ai/charts/multica \
  --namespace multica \
  --set config.frontendOrigin=https://newdomain.com
```

## Uninstalling

```bash
helm uninstall multica --namespace multica
```

**Note:** This will not delete the PostgreSQL data if using external database. PVCs for backend uploads can be deleted separately if needed.

## Development

### Linting

```bash
helm lint multica
```

### Testing Templates

```bash
helm template multica multica --debug
```

### Dry Run

```bash
helm install multica multica --dry-run --debug --namespace multica
```

## Troubleshooting

### Pod stuck in Init state

The backend waits for PostgreSQL to be ready. Check:
```bash
kubectl logs -n multica deployment/multica-backend -c wait-for-postgres
```

### Frontend can't connect to backend

Verify the `REMOTE_API_URL` build arg is correctly set. It should point to the backend service URL.

### Database connection errors

- Verify `pgvector` extension is installed on your PostgreSQL
- Check connection string in backend logs
- Ensure network policies allow egress to database port (5432)

## Contributing

See the [main repository](https://github.com/timoa-ai/helm-charts) for contribution guidelines.

## License

[MIT License](https://github.com/timoa-ai/helm-charts/blob/main/LICENSE)
