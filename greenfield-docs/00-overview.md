# CodeMySpec — Greenfield Build Overview

## Vision

CodeMySpec is a **process-guided AI development workspace for Phoenix apps**. It keeps AI on rails using user stories, Phoenix contexts, one design doc per code file, and test-driven workflows.

**Core Philosophy:**
> "You architect, AI types. Contexts, design docs, and tests give the model no room to invent new architecture."

## Product Goals

1. **Clarify the story in 10 seconds** — Above the fold: Phoenix, AI assist, process over prompts, human still steering
2. **Fix broken UX** — Clear separation between marketing pages and workspace
3. **Top-tier dev tool brand** — Precision, dry humor, late-night desert highway aesthetic (not neon city)
4. **Concise copy** — Short, sharp, human. No over-explaining or AI hype
5. **Aligned mental model** — Stories → Contexts → Design docs → Tests → Code

## Build Scope

### Phase 1: Foundation (Core Workspace)
- Marketing site (homepage, method, docs, auth)
- App shell with navigation
- Projects, Stories, Contexts, Components, Sessions
- Basic authentication (stubbed for demo)

### Phase 2: Content System
- Content sync from Git repos
- Markdown/HTML/EEx rendering
- Scheduling, expiration, tagging, SEO

### Phase 3: AI & Automation
- Executive summary generation
- LLM-driven interviews
- External coding agent integration
- Session workflows (design/test/implementation)

### Phase 4: Integration & Polish
- VS Code extension
- GitHub integration
- Setup wizard
- Guided demos

## Technical Foundation

- **Phoenix 1.7+** with modern template system
- **LiveView** for real-time UI
- **Tailwind CSS + DaisyUI** for styling (no custom CSS experiments)
- **SQLite** for development (PostgreSQL for production)
- **Ecto** for database layer
- **Phoenix Contexts** for business logic organization

## Key Principles

1. **Use Phoenix defaults** — Let Phoenix auto-discover templates, use `embed_templates` for layouts
2. **One template system** — `.heex` for everything (controllers and LiveViews)
3. **DaisyUI first** — Prefer DaisyUI components over custom CSS
4. **Clean separation** — Marketing shell vs. app shell, clear routing
5. **Documentation-driven** — Build from specs, not ad-hoc

## Build Order

1. **Tech stack setup** — Phoenix project, Tailwind, DaisyUI, database
2. **Marketing site** — Homepage, method, docs, auth pages
3. **App shell** — Layout, navigation, empty states
4. **Core workspace** — Projects, Stories, Contexts, Components, Sessions
5. **Content system** — Sync, rendering, scheduling
6. **AI features** — Interviews, sessions, agent integration
7. **Polish** — VS Code, GitHub, setup wizard

See `06-implementation-guide.md` for detailed step-by-step instructions.

