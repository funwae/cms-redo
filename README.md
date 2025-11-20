# CodeMySpec

A modern content management system built with Phoenix LiveView.

## Tech Stack

- **Phoenix 1.7+** - Web framework
- **LiveView** - Real-time UI
- **Ecto + SQLite** - Database (PostgreSQL supported)
- **Tailwind CSS** - Styling
- **DaisyUI** - Component library

## Development

### Setup

```bash
# Install dependencies
mix deps.get
cd assets && npm install && cd ..

# Create database
mix ecto.create
mix ecto.migrate

# Seed database (optional)
mix run priv/repo/seeds.exs

# Start server
mix phx.server
```

Visit `http://localhost:4000` to see the app.

## Project Structure

- `lib/code_my_spec/` - Business logic and contexts
- `lib/code_my_spec_web/` - Web layer (controllers, LiveViews, templates)
- `priv/repo/` - Database migrations
- `config/` - Application configuration

## Deployment

See [HANDOFF.md](./HANDOFF.md) for deployment instructions.

## License

See LICENSE file for details.
