# CodeMySpec — Greenfield Rebuild

This repository contains the complete specification for rebuilding CodeMySpec from scratch using Phoenix 1.7+ best practices.

## Quick Start

1. **Read the specs** in `greenfield-docs/`:
   - Start with `greenfield-docs/README.md` for an overview
   - Follow `greenfield-docs/06-implementation-guide.md` for step-by-step instructions

2. **Create a new Phoenix project**:
   ```bash
   mix phx.new code_my_spec --no-ecto
   cd code_my_spec
   ```

3. **Follow the implementation guide**:
   - Set up tech stack (`greenfield-docs/01-tech-stack.md`)
   - Create database schema (`greenfield-docs/02-architecture.md`)
   - Build marketing site (`greenfield-docs/03-marketing-site.md`)
   - Build app shell (`greenfield-docs/04-app-shell.md`)

## What's Included

- **Complete specs** for Phase 1 (Core Workspace)
- **Phoenix 1.7+ best practices** (no workarounds)
- **DaisyUI + Tailwind** component guide
- **Step-by-step implementation** instructions
- **All copy and microcopy** for the app

## Key Principles

- Use Phoenix defaults (auto-discovery, `embed_templates`)
- `.heex` for everything (controllers and LiveViews)
- DaisyUI first (no custom CSS experiments)
- Clean separation (marketing vs. app shell)

## Next Steps

1. Review `greenfield-docs/00-overview.md` for vision and goals
2. Follow `greenfield-docs/06-implementation-guide.md` to build Phase 1
3. Reference other docs as needed during development

---

**Note**: This is a clean rebuild spec. The original project code is not included - follow the specs to build from scratch.

