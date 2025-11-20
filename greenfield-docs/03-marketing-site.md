# Marketing Site Structure

## Pages

1. `/` — Homepage
2. `/method` — Methodology overview
3. `/blog` — Blog index
4. `/blog/:slug` — Blog post
5. `/docs` — Docs/guides index
6. `/log-in` — Login page
7. `/register` — Registration page

## Layout

**Marketing Layout** (`layouts/marketing.html.heex`):
- Header with logo, nav (Product, Method, Blog, Docs), auth links
- Footer with copyright
- Subtle animated background (optional, keep it minimal)

**Root Layout** (`layouts/root.html.heex`):
- HTML structure, head, fonts, CSS/JS includes
- Wraps both marketing and app layouts

## Homepage (`/`)

### Hero Section
- **Eyebrow**: "Process-guided AI development for Phoenix"
- **H1**: "Keep your architecture. Let AI do the typing."
- **Subtext**:
  > CodeMySpec wraps LLMs in strict workflows, Phoenix contexts, and one design doc per file.
  > You stay in charge of the system. The model just fills in the blanks.
- **Primary CTA**: "Open the workspace" → `/app` (or `/log-in` if not authenticated)
- **Secondary CTA**: "See the method" → `/method`

### Why This Exists (3 cards)

**Card 1: LLMs invent architecture**
> Give an LLM a vague brief and it happily makes up its own layers inside your app. It compiles. It passes tests. And it quietly ignores your Phoenix contexts.

**Card 2: The manual process works**
> With Markdown, Git, and a good model you can keep things under control: one design doc per file, strict context boundaries, tests first. It's just a lot to juggle by hand.

**Card 3: CodeMySpec automates the boring parts**
> CodeMySpec turns that manual workflow into a workspace. Stories, contexts, designs, tests, and sessions all live in one place, with AI running inside the guardrails.

### How It Works (3 steps)

1. **Stories** — "Capture what the app needs to do in plain language."
2. **Contexts & design docs** — "Map stories to Phoenix contexts. Write one small design doc per file."
3. **Tests & code** — "Let AI generate tests and implementations that match the design."

Include a simple diagram: Stories → Contexts → Design Docs → Tests → Code

### What You Get (feature grid)

- **User stories** — Host interviews, write, and curate stories that drive the entire design.
- **Phoenix contexts & components** — Define contexts, components, and their dependencies so AI can't improvise structure.
- **Sessions & workflows** — Run AI sessions that follow strict steps: design → tests → implementation.
- **Content & docs** — Render docs alongside your app. Keep specs, ADRs, and guides where you actually work.
- **Traceability** — Every file ties back to a story, a context, and a design doc.

### For Who?

- Solo Phoenix devs who work with Claude / Cursor
- Small teams shipping real apps with LLM assist
- Leads who care about architectural hygiene

### Closing CTA

> "Want LLMs in your workflow without letting them design your system?"

- `Open the workspace`
- Link: `Or read the long-form methodology` → `/method`

## Methodology Page (`/method`)

### Sections

1. **Intro** — "This is the manual process CodeMySpec automates."

2. **Phases**:
   - Stories — Capture requirements
   - Architecture — Map to Phoenix contexts
   - Design docs — One per file
   - Test generation — From design docs
   - Implementation — AI fills in code

3. **Links to deeper reads**:
   - "How to write design documents that keep AI from going off the rails"
   - User stories guide
   - Context mapping guide

## Blog (`/blog`)

- Index page with cards: title, excerpt, tags, date
- "Draft" badges for unpublished posts
- Simple pagination

## Docs Index (`/docs`)

- Curated list of guides:
  - Design doc guide
  - User story guide
  - Context mapping guide
  - Any future "how-to" pages

## Auth Pages

### Login (`/log-in`)
- Simple form: email, password
- "Log in" button
- Link to register
- For demo: stub authentication (set session, redirect to `/app`)

### Register (`/register`)
- Form: name, email, password, confirm password
- "Create account" button
- Link to login
- For demo: stub registration (create user, set session, redirect to `/app`)

## Routing

```elixir
# Marketing routes
scope "/", CodeMySpecWeb do
  pipe_through [:browser, :marketing_layout]

  get "/", PageController, :home
  get "/method", PageController, :method
  get "/docs", PageController, :docs
  get "/blog", BlogController, :index
  get "/blog/:slug", BlogController, :show
  get "/log-in", AuthController, :login
  get "/register", AuthController, :register
end
```

## Controllers

**PageController:**
- `home/2` — Renders `templates/page/home.html.heex`
- `method/2` — Renders `templates/page/method.html.heex`
- `docs/2` — Renders `templates/page/docs.html.heex`

**AuthController:**
- `login/2` — Renders `templates/auth/login.html.heex`
- `register/2` — Renders `templates/auth/register.html.heex`
- `create/2` — Handles login (stub: set session, redirect)
- `register_user/2` — Handles registration (stub: create user, set session, redirect)

## Styling

- Use DaisyUI components: `card`, `btn`, `input`, `form`
- Use Tailwind utilities for spacing, typography
- Brand colors from `tailwind.config.js`
- Keep it clean and minimal — no custom CSS experiments

