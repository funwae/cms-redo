# Deployment Handoff Guide

This guide will help you deploy CodeMySpec to Fly.io.

## Prerequisites

1. **Fly.io account** - Sign up at [fly.io](https://fly.io)
2. **Fly CLI** - Install: `curl -L https://fly.io/install.sh | sh`
3. **GitHub access** - Repository should be accessible

## Quick Start

### 1. Login to Fly.io

```bash
fly auth login
```

### 2. Create the App

```bash
fly launch
```

This will:
- Detect the `fly.toml` configuration
- Create a new app (or use existing)
- Set up a volume for persistent storage (SQLite)
- Deploy the application

### 3. Configure Environment Variables

Set the required environment variables:

```bash
# Generate a secret key
SECRET_KEY_BASE=$(mix phx.gen.secret)

# Set environment variables
fly secrets set SECRET_KEY_BASE="$SECRET_KEY_BASE"
fly secrets set PHX_HOST="your-app-name.fly.dev"  # Replace with your app name
fly secrets set MIX_ENV="prod"
fly secrets set PHX_SERVER="true"
```

### 4. Database Configuration

#### Option A: SQLite (Default - Already Configured)

The app is configured to use SQLite with a persistent volume. The `fly.toml` includes:

```toml
[[mounts]]
  source = "code_my_spec_data"
  destination = "/data"
```

The database will be stored at `/data/code_my_spec_prod.db` and persist across deployments.

#### Option B: PostgreSQL (Recommended for Production)

If you prefer PostgreSQL:

1. **Create a PostgreSQL database:**
   ```bash
   fly postgres create --name code-my-spec-db
   ```

2. **Attach it to your app:**
   ```bash
   fly postgres attach --app code-my-spec code-my-spec-db
   ```

3. **Set the DATABASE_URL:**
   ```bash
   fly secrets set DATABASE_URL="$(fly postgres connect -a code-my-spec-db -c 'echo $DATABASE_URL')"
   ```

   Or manually set it:
   ```bash
   fly secrets set DATABASE_URL="postgresql://user:password@host:port/database"
   ```

The app will automatically detect `DATABASE_URL` and use PostgreSQL instead of SQLite.

### 5. Deploy

```bash
fly deploy
```

The deployment will:
- Build the Docker image
- Run database migrations automatically (via `release_command` in `fly.toml`)
- Start the application

### 6. Verify Deployment

```bash
# Check app status
fly status

# View logs
fly logs

# Open in browser
fly open
```

## Configuration Files

### `fly.toml`

The main Fly.io configuration file. Key settings:

- **App name**: `app = "code-my-spec"` (change if needed)
- **Region**: `primary_region = "iad"` (change to your preferred region)
- **Volume mount**: Configured for SQLite persistence
- **Release command**: Automatically runs migrations on deploy

### Environment Variables

Required variables (set via `fly secrets set`):

- `SECRET_KEY_BASE` - Secret key for session encryption (generate with `mix phx.gen.secret`)
- `PHX_HOST` - Your app's hostname (e.g., `your-app.fly.dev`)
- `MIX_ENV` - Set to `prod`
- `PHX_SERVER` - Set to `true`

Optional variables:

- `DATABASE_URL` - PostgreSQL connection string (if using PostgreSQL)
- `DATABASE_PATH` - SQLite file path (defaults to `/data/code_my_spec_prod.db`)
- `SIGNING_SALT` - Session signing salt (auto-generated if not set)

## Custom Domain

To use a custom domain:

1. **Add the domain:**
   ```bash
   fly certs add yourdomain.com
   ```

2. **Update PHX_HOST:**
   ```bash
   fly secrets set PHX_HOST="yourdomain.com"
   ```

3. **Redeploy:**
   ```bash
   fly deploy
   ```

## Scaling

### Scale Resources

```bash
# Scale VM resources
fly scale vm shared-cpu-1x --memory 1024

# Scale to multiple instances
fly scale count 2
```

### Scale Database

If using PostgreSQL, scale the database separately:

```bash
fly postgres scale --vm-size shared-cpu-1x --volume-size 10
```

## Maintenance

### Run Migrations Manually

```bash
fly ssh console -C "/app/bin/code_my_spec eval 'CodeMySpec.Release.migrate()'"
```

### Access Database Console

**SQLite:**
```bash
fly ssh console
sqlite3 /data/code_my_spec_prod.db
```

**PostgreSQL:**
```bash
fly postgres connect -a code-my-spec-db
```

### View Logs

```bash
# Real-time logs
fly logs

# Historical logs
fly logs --app code-my-spec
```

## Troubleshooting

### App Won't Start

1. Check logs: `fly logs`
2. Verify secrets are set: `fly secrets list`
3. Check database connectivity
4. Verify `PHX_HOST` matches your app URL

### Database Issues

1. **SQLite permission errors**: Ensure volume is mounted correctly
2. **PostgreSQL connection**: Verify `DATABASE_URL` is correct
3. **Migration failures**: Check logs for specific error messages

### Build Failures

1. Check Docker build logs: `fly logs --build`
2. Verify all dependencies are in `mix.exs`
3. Ensure `mix.lock` is committed

## Support

For Fly.io specific issues, see:
- [Fly.io Documentation](https://fly.io/docs)
- [Phoenix on Fly.io Guide](https://fly.io/docs/elixir/getting-started/)

For application issues, check the application logs:
```bash
fly logs
```

## Next Steps

1. Set up monitoring and alerts
2. Configure backups (if using PostgreSQL)
3. Set up CI/CD for automated deployments
4. Review and adjust resource limits based on usage

