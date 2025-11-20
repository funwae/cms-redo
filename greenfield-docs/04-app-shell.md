# App Shell (Authenticated Workspace)

## Layout

**App Layout** (`layouts/app.html.heex`):
- DaisyUI drawer component (sidebar + main content)
- Top navbar with project selector, status badge
- Left sidebar with navigation
- Main content area

## Navigation Structure

### Sidebar (persistent)

1. **Logo + wordmark** — CodeMySpec |> phoenix mark
2. **Primary nav**:
   - Overview
   - Projects
   - Stories
   - Components
   - Sessions
   - Architecture
   - Content
3. **Secondary** (bottom):
   - Settings

### Top Bar

- **Project selector** — Dropdown if multiple projects
- **Status badge** — "Synced" / "Out of sync"
- **Optional**: "Open in VS Code" link or extension note

## Key Screens

### 1. Overview (`/app/`)

**Purpose**: Dashboard when you log in

**Content**:
- Currently selected project (or "No project yet" with CTA)
- **Stats panel** (DaisyUI `stats`):
  - # of stories
  - # of components
  - # of design docs
  - Test status summary
- **Active workflows** (card):
  - List of current sessions: "Designing Billing context", "Tests for Orders.LiveView"
- **Trace line** (card):
  - Visual: Stories → Contexts → Design docs → Tests → Code
  - Counts for each stage

### 2. Projects (`/app/projects`)

**List view**:
- DaisyUI table:
  - Name
  - Repository (GitHub link)
  - Framework (Phoenix)
  - Status badge (`active`, `archived`)
  - Actions: "Open" button

**Detail view** (`/app/projects/:id`):
- Tabs or sub-nav:
  - Overview (same as main Overview but project-scoped)
  - Stories
  - Components
  - Architecture
  - Sessions
  - Settings

### 3. Stories (`/app/stories`)

**List view**:
- DaisyUI tabs: "All" / "Draft" / "Ready" / "Implemented"
- DaisyUI table:
  - Title
  - Description (truncated)
  - Status badge
  - Linked contexts/components (links)
  - Actions: "View" button

**Detail view** (`/app/stories/:id`):
- Story text
- Acceptance criteria
- Linked contexts, components, design docs
- Button: "Start design session"

### 4. Architecture (`/app/architecture`)

**List view**:
- Cards or table:
  - Context name
  - Type badge (`domain`, `coordination`)
  - Purpose
  - Related stories count
  - Related components count

**Detail view** (`/app/architecture/:id`):
- Context description
- Entities / schemas
- Operations (functions / endpoints)
- List of design docs
- Mapped stories

### 5. Components (`/app/components`)

**List view**:
- DaisyUI table:
  - Name
  - Type badge (`context`, `schema`, `liveview`, etc.)
  - Context
  - Status badges: `docs_complete`, `code_complete`, `tests_complete`
  - Actions: "View" button

**Detail view** (`/app/components/:id`):
- Component info
- Links to design docs
- Dependencies
- Actions: "Generate tests" / "Generate implementation"

### 6. Sessions (`/app/sessions`)

**List view**:
- DaisyUI table:
  - Type badge (`design`, `test`, `implementation`, `setup`)
  - Target (Component / Context)
  - Status badge (`pending`, `in_progress`, `complete`, `failed`)
  - Created at
  - Actions: "View" / "Resume" button

**Detail view** (`/app/sessions/:id`):
- Timeline of steps (log/transcript summary)
- Buttons: "Resume" or "Re-run"

### 7. Content (`/app/content`)

**List view**:
- List of pages, docs, guides
- Simple markdown editor/viewer (future)

### 8. Settings (`/app/settings`)

**Subsections**:
- Account (user profile)
- Workspace / org (if any)
- Integrations (GitHub, Claude endpoints)
- API tokens

## Empty States

Each main screen has a friendly empty state:

- **No stories yet** → CTA: "Create your first story"
- **No contexts yet** → CTA: "Import from docs/architecture.md" or "Add a context"
- **No sessions yet** → CTA: "Start a design session"
- **No project yet** → CTA: "Create a project"

Copy should feel like a peer poking you, not a dashboard nagging.

## Routing

```elixir
# App routes (authenticated)
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

## LiveViews

All app screens use LiveView:
- `AppLive.Overview`
- `AppLive.Projects` / `AppLive.ProjectDetail`
- `AppLive.Stories` / `AppLive.StoryDetail`
- `AppLive.Components` / `AppLive.ComponentDetail`
- `AppLive.Sessions` / `AppLive.SessionDetail`
- `AppLive.Architecture`
- `AppLive.Content`
- `AppLive.Settings`

## Styling

- Use DaisyUI components: `drawer`, `navbar`, `menu`, `table`, `card`, `badge`, `tabs`, `stats`
- Use Tailwind utilities for spacing, typography
- Brand colors from `tailwind.config.js`
- Keep it clean and consistent — no custom CSS experiments

## Auth Plug

```elixir
defmodule CodeMySpecWeb.Plugs.Auth do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    # For demo: stub authentication
    # TODO: Implement real auth
    user_id = get_session(conn, :user_id) || Ecto.UUID.generate()
    put_session(conn, :user_id, user_id)
  end
end
```

