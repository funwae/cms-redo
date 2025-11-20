# Feature Epics & Build Phases

This document organizes features into build phases, from the original `cms-06-feature-epics-and-scope.md` and `cms-07-personas-and-end-to-end-flows.md`.

## Phase 1: Core Workspace (Foundation)

**Goal**: Get the basic workspace working with navigation and core entities.

### Features
- Marketing site (homepage, method, docs, auth)
- App shell with navigation
- Projects CRUD
- Stories CRUD with status management
- Contexts CRUD (domain/coordination types)
- Components CRUD with status flags
- Sessions CRUD (design/test/implementation/setup types)
- Basic authentication (stubbed for demo)

### Data Model
- All core tables from `02-architecture.md`
- Migrations for accounts, projects, stories, contexts, components, sessions
- Basic Phoenix contexts for each entity

### UI
- DaisyUI components throughout
- Empty states for all screens
- Basic filtering (stories by status)
- Project selector in top bar

## Phase 2: Content System

**Goal**: Content sync, rendering, and publishing.

### Features
- Content sync from Git repos (posts/pages/landing)
- Markdown/HTML/EEx processing
- Frontmatter parsing (slug, type, publish_at, expires_at, SEO, tags)
- Content rendering in LiveView
- Routes: `/blog/:slug`, `/pages/:slug`, `/landing/:slug`
- Sync status monitoring
- Dev file watcher for real-time preview

### Data Model
- `contents` table
- `content_tags` join table
- `tags` table

### UI
- Content list page
- Content detail page
- Sync status page
- Preview routes

## Phase 3: AI & Automation

**Goal**: LLM-driven workflows and agent integration.

### Features
- Executive summary generation (LLM interview)
- User story interview (LLM-driven)
- User story completeness review
- Design doc generation from contexts/components
- Documentation review process
- Session workflows (design → tests → implementation)
- External coding agent integration (Claude Code via MCP)
- Retry management and failure handling

### Data Model
- Extend `sessions` with transcript/log fields
- Add `executive_summaries` table
- Add `interviews` table

### UI
- Interview flow pages
- Session detail with timeline
- Design doc editor/reviewer
- Approval workflows

## Phase 4: Integration & Polish

**Goal**: VS Code extension, GitHub, setup wizard, guided demos.

### Features
- VS Code extension (file scanning, status sync, next actions)
- GitHub integration (OAuth, repo creation, branch/PR management)
- Setup wizard (one-pager, linear steps)
- Project setup session (coordination context)
- Next action recommendations API
- Component status tracking (docs/code/tests complete)
- Guided demo validation
- Multi-user coordination (locking, optimistic concurrency)

### Data Model
- `github_integrations` table
- `setup_sessions` table
- Extend `projects` with setup state

### UI
- Setup wizard flow
- GitHub integration settings
- VS Code extension status
- Next actions dashboard

## Personas & Flows

### PM / Founder
- Executive summary → User story interview → Story management → Project dashboard

### Architect
- Context mapping → Design doc review → Integration testing → Redesign workflows

### Developer
- VS Code extension → Next actions → Component status → Sessions

### Content Creator
- Content sync → Scheduling → Tagging → Preview

### Stakeholder
- Guided demo → Requirements traceability → High-level dashboard

## Out of Scope (for initial build)

- Complex RBAC (start with simple user/project ownership)
- Full VS Code extension (start with API endpoints)
- Production OAuth flows (start with stubs)
- Advanced retry/postmortem automation (start with basic failure handling)

## Build Order

1. **Phase 1** — Core workspace (this is the foundation)
2. **Phase 2** — Content system (can be built in parallel with Phase 3)
3. **Phase 3** — AI features (depends on Phase 1)
4. **Phase 4** — Integration (depends on Phases 1-3)

See `06-implementation-guide.md` for detailed step-by-step instructions for Phase 1.

