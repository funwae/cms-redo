# CodeMySpec Greenfield Build Specs

This folder contains the complete specification for rebuilding CodeMySpec from scratch using Phoenix 1.7+ best practices and John's preferred stack (Phoenix + LiveView + Tailwind + DaisyUI).

## Document Structure

### 00-overview.md
High-level vision, goals, build scope, and key principles. Start here to understand what we're building and why.

### 01-tech-stack.md
Complete technical stack definition, Phoenix 1.7+ best practices, and setup instructions. This is the foundation for everything else.

### 02-architecture.md
Database schema, Phoenix contexts, and data model. All tables, relationships, and business logic organization.

### 03-marketing-site.md
Public-facing pages: homepage, method, docs, blog, auth. Layout, routing, and content structure.

### 04-app-shell.md
Authenticated workspace: navigation, screens, empty states, and routing. The core app experience.

### 05-features.md
Feature epics organized by build phase. What to build when, and how features relate to personas and flows.

### 06-implementation-guide.md
Step-by-step instructions for Phase 1 (Core Workspace). Detailed, actionable guide from project setup to first working version.

### 07-ui-components.md
DaisyUI component usage guide. What components to use, how to use them, and what to avoid.

### 08-copy.md
All copy and microcopy for marketing site and app shell. Tone, voice, and specific text for every screen.

## How to Use These Specs

### For Builders

1. **Read 00-overview.md** — Understand the vision and scope
2. **Read 01-tech-stack.md** — Set up the technical foundation
3. **Follow 06-implementation-guide.md** — Build Phase 1 step-by-step
4. **Reference other docs** as needed:
   - `02-architecture.md` for database schema
   - `03-marketing-site.md` and `04-app-shell.md` for UI structure
   - `07-ui-components.md` for component usage
   - `08-copy.md` for all text content

### For Reviewers

- **00-overview.md** — Product vision and goals
- **05-features.md** — Feature scope and build phases
- **02-architecture.md** — Data model and business logic

## Key Principles

1. **Use Phoenix defaults** — Let Phoenix auto-discover templates, use `embed_templates` for layouts
2. **One template system** — `.heex` for everything (controllers and LiveViews)
3. **DaisyUI first** — Prefer DaisyUI components over custom CSS
4. **Clean separation** — Marketing shell vs. app shell, clear routing
5. **Documentation-driven** — Build from specs, not ad-hoc

## Build Phases

### Phase 1: Core Workspace (Foundation)
- Marketing site
- App shell with navigation
- Projects, Stories, Contexts, Components, Sessions
- Basic authentication (stubbed)

### Phase 2: Content System
- Content sync from Git repos
- Markdown/HTML/EEx rendering
- Scheduling, expiration, tagging, SEO

### Phase 3: AI & Automation
- Executive summary generation
- LLM-driven interviews
- External coding agent integration
- Session workflows

### Phase 4: Integration & Polish
- VS Code extension
- GitHub integration
- Setup wizard
- Guided demos

## Lessons Learned

These specs incorporate lessons from the initial build:

- **Phoenix 1.7+ template system** — Use `.heex` for controllers, `embed_templates` for layouts
- **No manual template resolution** — Let Phoenix handle it automatically
- **DaisyUI consistency** — Avoid custom CSS experiments
- **Clean architecture** — Separate concerns, use Phoenix contexts properly
- **Simple auth stubs** — Get the UI working first, add real auth later

## Questions?

If something is unclear or missing:
1. Check the relevant spec document
2. Reference the original docs in `../docs/` for additional context
3. Follow Phoenix 1.7+ best practices from `01-tech-stack.md`

## Next Steps

1. Review all specs
2. Set up project following `01-tech-stack.md`
3. Build Phase 1 following `06-implementation-guide.md`
4. Test and iterate
5. Move to Phase 2 when ready

---

**Remember**: These specs are designed to be complete, actionable, and aligned with Phoenix 1.7+ best practices. Follow them step-by-step, and you'll have a clean, maintainable CodeMySpec build.

