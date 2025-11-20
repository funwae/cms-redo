# Tech Stack & Setup

## Core Stack

- **Phoenix 1.7+** — Latest stable version
- **Elixir 1.14+** — Language runtime
- **LiveView** — Real-time, server-rendered UI
- **Tailwind CSS** — Utility-first CSS
- **DaisyUI** — Component library for Tailwind
- **Ecto** — Database wrapper and query language
- **SQLite** — Development database (via `ecto_sqlite3`)
- **PostgreSQL** — Production database (via `postgrex`)

## Phoenix 1.7+ Best Practices

### Template System

**Controllers use `.heex` templates:**
- Templates in `lib/code_my_spec_web/templates/`
- Phoenix auto-discovers them (no manual `render/2` needed)
- Use `Phoenix.Template` with `.heex` pattern

**LiveViews use `~H` sigil:**
- Define templates inline with `~H"""` sigil
- Or use `embed_templates` for shared components
- Use `Phoenix.Component` for layouts

**Layouts use `embed_templates`:**
- One layout module: `CodeMySpecWeb.Layouts`
- Use `embed_templates "layouts/*.html.heex"`
- Let Phoenix generate the functions automatically

### Project Structure

```
lib/
├── code_my_spec/              # Business logic (contexts)
│   ├── accounts/
│   ├── projects/
│   ├── stories/
│   ├── architecture/
│   ├── components/
│   └── sessions/
├── code_my_spec_web/          # Web layer
│   ├── controllers/           # Controller actions
│   ├── live/                  # LiveView modules
│   ├── templates/             # .heex templates (controllers)
│   ├── layouts/               # Layout templates
│   ├── components/            # Reusable components
│   └── plugs/                 # Plugs (auth, etc.)
```

### Dependencies

```elixir
# mix.exs
defp deps do
  [
    {:phoenix, "~> 1.7"},
    {:phoenix_live_view, "~> 0.20"},
    {:phoenix_html, "~> 4.0"},
    {:phoenix_live_reload, "~> 1.4", only: :dev},
    {:gettext, "~> 0.23"},
    {:jason, "~> 1.4"},
    {:plug_cowboy, "~> 2.6"},
    {:tailwind, "~> 0.2", runtime: Mix.env() == :dev},
    {:esbuild, "~> 0.8", runtime: Mix.env() == :dev},
    {:ecto_sql, "~> 3.11"},
    {:ecto_sqlite3, "~> 0.11"},
    {:phoenix_ecto, "~> 4.5"},
    {:daisyui, "~> 0.1", only: :dev}  # Via npm
  ]
end
```

### Tailwind + DaisyUI Setup

**tailwind.config.js:**
```javascript
module.exports = {
  content: [
    "./js/**/*.js",
    "../lib/*_web/**/*.*ex"
  ],
  theme: {
    extend: {
      colors: {
        'cms-black': '#050308',
        'cms-charcoal': '#0b0f18',
        'cms-charcoal-light': '#111827',
        'cms-orange': '#f97316',
        'cms-purple': '#7e22ce',
        'cms-aqua': '#22d3ee',
        'cms-sand': '#fbbf77',
      },
      fontFamily: {
        'heading': ['Space Grotesk', 'sans-serif'],
        'body': ['Inter', 'system-ui', 'sans-serif'],
      },
    },
  },
  plugins: [
    require('daisyui'),
  ],
  daisyui: {
    themes: [
      {
        codemyspec: {
          "primary": "#f97316",
          "secondary": "#7e22ce",
          "accent": "#22d3ee",
          "neutral": "#0b0f18",
          "base-100": "#050308",
          "base-200": "#0b0f18",
          "base-300": "#111827",
        },
      },
    ],
  },
}
```

**assets/css/app.css:**
```css
@tailwind base;
@tailwind components;
@tailwind utilities;

/* Minimal custom CSS - prefer Tailwind utilities */
```

### Database Setup

**Development (SQLite):**
```elixir
# config/dev.exs
config :code_my_spec, CodeMySpec.Repo,
  database: "priv/repo/code_my_spec_dev.db",
  pool_size: 10
```

**Production (PostgreSQL):**
```elixir
# config/runtime.exs
config :code_my_spec, CodeMySpec.Repo,
  url: System.get_env("DATABASE_URL"),
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
```

### CodeMySpecWeb Module

```elixir
defmodule CodeMySpecWeb do
  def controller do
    quote do
      use Phoenix.Controller, namespace: CodeMySpecWeb
      import Plug.Conn
      import CodeMySpecWeb.Gettext
      alias CodeMySpecWeb.Router.Helpers, as: Routes
    end
  end

  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {CodeMySpecWeb.Layouts, :app}

      unquote(view_helpers())
    end
  end

  def view do
    quote do
      use Phoenix.Template,
        root: "lib/code_my_spec_web/templates",
        namespace: CodeMySpecWeb,
        pattern: "*.heex"  # Use .heex for everything

      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      unquote(view_helpers())
    end
  end

  def html do
    quote do
      use Phoenix.Component
      unquote(view_helpers())
    end
  end

  defp view_helpers do
    quote do
      import Phoenix.HTML
      import Phoenix.HTML.Form
      import Phoenix.LiveView.Helpers
      import CodeMySpecWeb.CoreComponents
      import CodeMySpecWeb.Gettext
      alias CodeMySpecWeb.Router.Helpers, as: Routes
    end
  end
end
```

## Key Differences from Old Approach

1. **No manual `EEx.eval_file`** — Use `embed_templates` or let Phoenix auto-discover
2. **No hardcoded paths** — Phoenix handles template resolution
3. **`.heex` for controllers** — Not just LiveViews
4. **One layout system** — `embed_templates` for all layouts
5. **No custom CSS experiments** — DaisyUI + Tailwind only

