# Implementation Guide — Phase 1: Core Workspace

This guide walks through building Phase 1 step-by-step, using Phoenix 1.7+ best practices.

## Step 1: Project Setup

### 1.1 Create Phoenix Project

```bash
mix phx.new code_my_spec --no-ecto
cd code_my_spec
```

### 1.2 Add Dependencies

Update `mix.exs`:

```elixir
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
  ]
end
```

### 1.3 Install Dependencies

```bash
mix deps.get
mix assets.setup
```

### 1.4 Configure Tailwind + DaisyUI

**Install DaisyUI:**
```bash
cd assets
npm install -D daisyui
cd ..
```

**Update `assets/tailwind.config.js`:**
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

**Update `assets/css/app.css`:**
```css
@tailwind base;
@tailwind components;
@tailwind utilities;
```

### 1.5 Configure Ecto

**Update `config/dev.exs`:**
```elixir
config :code_my_spec, CodeMySpec.Repo,
  database: "priv/repo/code_my_spec_dev.db",
  pool_size: 10
```

**Create `lib/code_my_spec/repo.ex`:**
```elixir
defmodule CodeMySpec.Repo do
  use Ecto.Repo,
    otp_app: :code_my_spec,
    adapter: Ecto.Adapters.SQLite3
end
```

**Update `lib/code_my_spec/application.ex`:**
```elixir
children = [
  CodeMySpec.Repo,
  # ... other children
]
```

## Step 2: Database Setup

### 2.1 Create Migrations

```bash
mix ecto.gen.migration create_accounts
mix ecto.gen.migration create_projects
mix ecto.gen.migration create_project_memberships
mix ecto.gen.migration create_stories
mix ecto.gen.migration create_contexts
mix ecto.gen.migration create_context_stories
mix ecto.gen.migration create_components
mix ecto.gen.migration create_component_dependencies
mix ecto.gen.migration create_design_docs
mix ecto.gen.migration create_sessions
```

### 2.2 Write Migrations

Follow the schema from `02-architecture.md`. Use UUID primary keys, proper indexes, and foreign key constraints.

### 2.3 Run Migrations

```bash
mix ecto.create
mix ecto.migrate
```

## Step 3: Phoenix Contexts

### 3.1 Create Context Modules

Create:
- `lib/code_my_spec/accounts/account.ex` (schema)
- `lib/code_my_spec/accounts.ex` (context)
- `lib/code_my_spec/projects/project.ex` (schema)
- `lib/code_my_spec/projects/project_membership.ex` (schema)
- `lib/code_my_spec/projects.ex` (context)
- `lib/code_my_spec/stories/story.ex` (schema)
- `lib/code_my_spec/stories.ex` (context)
- `lib/code_my_spec/architecture/context.ex` (schema)
- `lib/code_my_spec/architecture/context_story.ex` (schema)
- `lib/code_my_spec/architecture.ex` (context)
- `lib/code_my_spec/components/component.ex` (schema)
- `lib/code_my_spec/components/component_dependency.ex` (schema)
- `lib/code_my_spec/components/design_doc.ex` (schema)
- `lib/code_my_spec/components.ex` (context)
- `lib/code_my_spec/sessions/session.ex` (schema)
- `lib/code_my_spec/sessions.ex` (context)

### 3.2 Implement Context Functions

Follow the API from `02-architecture.md`. Keep it simple — basic CRUD + status management.

## Step 4: Layouts

### 4.1 Root Layout

**Create `lib/code_my_spec_web/layouts/root.html.heex`:**
```heex
<!DOCTYPE html>
<html lang="en" class="h-full">
  <head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <meta name="csrf-token" content={get_csrf_token()} />
    <title><%= assigns[:page_title] || "CodeMySpec" %> · CodeMySpec</title>
    <link phx-track-static rel="stylesheet" href="/assets/app.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@400;500;600;700&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <script defer phx-track-static type="text/javascript" src="/assets/app.js"></script>
  </head>
  <body class="h-full antialiased" data-theme="codemyspec">
    <%= @inner_content %>
  </body>
</html>
```

### 4.2 Marketing Layout

**Create `lib/code_my_spec_web/layouts/marketing.html.heex`:**
```heex
<div class="min-h-screen flex flex-col">
  <header class="border-b border-base-300">
    <nav class="navbar max-w-7xl mx-auto">
      <div class="flex-1">
        <a href="/" class="btn btn-ghost text-xl">
          <img src="/images/cms-logo.svg" alt="CodeMySpec" class="h-8 w-8" />
          CodeMySpec
        </a>
      </div>
      <div class="flex-none">
        <ul class="menu menu-horizontal px-1">
          <li><a href="/">Product</a></li>
          <li><a href="/method">Method</a></li>
          <li><a href="/blog">Blog</a></li>
          <li><a href="/docs">Docs</a></li>
        </ul>
      </div>
      <div class="flex-none">
        <a href="/log-in" class="btn btn-ghost">Log in</a>
        <a href="/app" class="btn btn-primary">Open workspace</a>
      </div>
    </nav>
  </header>

  <main class="flex-1">
    <%= @inner_content %>
  </main>

  <footer class="border-t border-base-300">
    <div class="max-w-7xl mx-auto px-6 py-6 text-sm text-base-content/70">
      <div>© <%= Date.utc_today().year %> CodeMySpec</div>
      <div>Built for Phoenix devs who actually care about architecture.</div>
    </div>
  </footer>
</div>
```

### 4.3 App Layout

**Create `lib/code_my_spec_web/layouts/app.html.heex`:**
```heex
<div class="drawer lg:drawer-open min-h-screen">
  <input id="drawer-toggle" type="checkbox" class="drawer-toggle" />

  <div class="drawer-content flex flex-col bg-base-100">
    <div class="navbar bg-base-200 border-b border-base-300">
      <div class="flex-none lg:hidden">
        <label for="drawer-toggle" class="btn btn-square btn-ghost">
          <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" class="inline-block w-5 h-5 stroke-current">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"></path>
          </svg>
        </label>
      </div>
      <div class="flex-1">
        <select class="select select-bordered select-sm">
          <option>Select project...</option>
        </select>
        <span class="badge badge-success badge-sm">Synced</span>
      </div>
    </div>

    <main class="flex-1 p-6">
      {@inner_content}
    </main>
  </div>

  <div class="drawer-side">
    <label for="drawer-toggle" class="drawer-overlay"></label>
    <aside class="w-64 min-h-full bg-base-200">
      <div class="p-6 border-b border-base-300">
        <a href="/app" class="flex items-center gap-3">
          <img src="/images/cms-logo.svg" alt="CodeMySpec" class="h-6 w-6" />
          <span class="text-lg font-heading font-semibold">CodeMySpec</span>
        </a>
      </div>
      <ul class="menu p-4 w-64 min-h-full text-base-content">
        <li><a href="/app">Overview</a></li>
        <li><a href="/app/projects">Projects</a></li>
        <li><a href="/app/stories">Stories</a></li>
        <li><a href="/app/components">Components</a></li>
        <li><a href="/app/sessions">Sessions</a></li>
        <li><a href="/app/architecture">Architecture</a></li>
        <li><a href="/app/content">Content</a></li>
        <li class="mt-auto"><a href="/app/settings">Settings</a></li>
      </ul>
    </aside>
  </div>
</div>
```

### 4.4 Layouts Module

**Create `lib/code_my_spec_web/layouts.ex`:**
```elixir
defmodule CodeMySpecWeb.Layouts do
  use CodeMySpecWeb, :html

  embed_templates "layouts/*.html.heex"
end
```

## Step 5: Marketing Site

### 5.1 Controllers

**Create `lib/code_my_spec_web/controllers/page_controller.ex`:**
```elixir
defmodule CodeMySpecWeb.PageController do
  use CodeMySpecWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def method(conn, _params) do
    render(conn, :method)
  end

  def docs(conn, _params) do
    render(conn, :docs)
  end
end
```

**Create `lib/code_my_spec_web/controllers/auth_controller.ex`:**
```elixir
defmodule CodeMySpecWeb.AuthController do
  use CodeMySpecWeb, :controller

  def login(conn, _params) do
    render(conn, :login)
  end

  def register(conn, _params) do
    render(conn, :register)
  end

  def create(conn, _params) do
    # STUB: Set session and redirect
    conn
    |> put_session(:user_id, Ecto.UUID.generate())
    |> redirect(to: "/app")
  end

  def register_user(conn, _params) do
    # STUB: Create user, set session, redirect
    conn
    |> put_session(:user_id, Ecto.UUID.generate())
    |> redirect(to: "/app")
  end
end
```

### 5.2 Templates

Create templates in `lib/code_my_spec_web/templates/`:
- `page/home.html.heex`
- `page/method.html.heex`
- `page/docs.html.heex`
- `auth/login.html.heex`
- `auth/register.html.heex`

Use DaisyUI components and follow copy from `08-copy.md`.

### 5.3 Router

```elixir
pipeline :marketing_layout do
  plug :put_layout, html: {CodeMySpecWeb.Layouts, :marketing}
end

scope "/", CodeMySpecWeb do
  pipe_through [:browser, :marketing_layout]

  get "/", PageController, :home
  get "/method", PageController, :method
  get "/docs", PageController, :docs
  get "/log-in", AuthController, :login
  post "/log-in", AuthController, :create
  get "/register", AuthController, :register
  post "/register", AuthController, :register_user
end
```

## Step 6: App Shell

### 6.1 Auth Plug

**Create `lib/code_my_spec_web/plugs/auth.ex`:**
```elixir
defmodule CodeMySpecWeb.Plugs.Auth do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    # STUB: For demo, always allow
    user_id = get_session(conn, :user_id) || Ecto.UUID.generate()
    put_session(conn, :user_id, user_id)
  end
end
```

### 6.2 Router

```elixir
pipeline :auth do
  plug CodeMySpecWeb.Plugs.Auth
end

scope "/app", CodeMySpecWeb do
  pipe_through [:browser, :auth]

  live "/", AppLive.Overview
  live "/projects", AppLive.Projects
  live "/projects/:id", AppLive.ProjectDetail
  live "/stories", AppLive.Stories
  live "/stories/:id", AppLive.StoryDetail
  live "/components", AppLive.Components
  live "/components/:id", AppLive.ComponentDetail
  live "/sessions", AppLive.Sessions
  live "/sessions/:id", AppLive.SessionDetail
  live "/architecture", AppLive.Architecture
  live "/content", AppLive.Content
  live "/settings", AppLive.Settings
end
```

### 6.3 LiveViews

Create LiveViews in `lib/code_my_spec_web/live/app_live/`:
- `overview.ex`
- `projects.ex` / `project_detail.ex`
- `stories.ex` / `story_detail.ex`
- `components.ex` / `component_detail.ex`
- `sessions.ex` / `session_detail.ex`
- `architecture.ex`
- `content.ex`
- `settings.ex`

Use DaisyUI components (`table`, `card`, `badge`, `stats`, `tabs`) and follow UI patterns from `04-app-shell.md`.

## Step 7: Testing

### 7.1 Run Tests

```bash
mix test
```

### 7.2 Manual Testing

1. Start server: `mix phx.server`
2. Test marketing pages: `/`, `/method`, `/docs`, `/log-in`, `/register`
3. Test app shell: `/app`, `/app/projects`, `/app/stories`, etc.
4. Check console for errors
5. Test responsive design (mobile/desktop)

## Step 8: Seeds

**Create `priv/repo/seeds.exs`:**
```elixir
alias CodeMySpec.{Accounts, Projects, Stories, Architecture, Components, Sessions}
alias CodeMySpec.Repo

# Create test user
user = Accounts.create_user!(%{
  email: "test@example.com",
  name: "Test User",
  hashed_password: "stub"
})

# Create test project
project = Projects.create_project!(%{
  name: "Test Project",
  description: "A test project",
  owner_id: user.id
})

# Create test stories
story1 = Stories.create_story!(%{
  title: "User can log in",
  description: "As a user, I want to log in so I can access my account.",
  project_id: project.id,
  status: "ready"
})

# ... more seeds
```

Run: `mix run priv/repo/seeds.exs`

## Next Steps

Once Phase 1 is complete:
1. Test all flows
2. Add empty states
3. Polish UI with DaisyUI
4. Move to Phase 2 (Content System) or Phase 3 (AI Features)

