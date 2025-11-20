# Current Site vs. Greenfield Spec Comparison

This document compares the current live site (codemyspec.com) with what the greenfield specs call for.

## Marketing Site Comparison

### Homepage

**Current Site:**
- Hero: "AI-Assisted Phoenix Development That Actually Ships"
- Eyebrow: "Process-Guided AI Development"
- Subtext: "Stop drowning in LLM-generated slop. Build production-ready Phoenix applications through structured workflows, clear component boundaries, and human oversight where it matters."
- CTA: "Get Started" → `/users/register`
- Features: "Process Over Prompts", "Phoenix-Native Architecture", "Human-in-the-Loop", "Complete Traceability"
- Platform Features: User Story Management, Component Architecture, Session Orchestration, Product Content, Security & Authorization
- Philosophy section: About strictly defined processes

**Greenfield Spec:**
- Hero: "Keep your architecture. Let AI do the typing."
- Eyebrow: "Process-guided AI development for Phoenix"
- Subtext: "CodeMySpec wraps LLMs in strict workflows, Phoenix contexts, and one design doc per file. You stay in charge of the system. The model just fills in the blanks."
- CTA: "Open the workspace" (primary), "See the method" (secondary)
- "Why this exists" cards: LLMs invent architecture, Manual process works, CodeMySpec automates boring parts
- "How it works": 3-step flow (Stories → Contexts & design docs → Tests & code)
- "What you get": Feature grid
- "For who?": Target audience
- Closing CTA

**Assessment:**
- ✅ Current site has good content but different structure
- ✅ Current messaging is more detailed/verbose
- ⚠️ Greenfield spec is more concise and action-oriented
- ⚠️ Current site lacks the "Why this exists" and "How it works" sections
- ⚠️ Current site has more features listed but less clear flow

### Methodology Page

**Current Site:**
- Very detailed 5-phase methodology
- "The Problem: Compounding Drift" section
- "The Solution: Control Context" section
- Detailed breakdown of each phase (Manual vs. Automated)
- Examples from CodeMySpec codebase
- "The Proof" section
- Getting Started (Manual vs. Automated)
- FAQ section
- Related Content links

**Greenfield Spec:**
- Simpler overview
- Intro: "This is the manual process CodeMySpec automates."
- Phases: Stories, Architecture, Design docs, Test generation, Implementation
- Links to deeper reads

**Assessment:**
- ✅ Current site has much more detail (good for SEO/content)
- ⚠️ Greenfield spec is more scannable/concise
- 💡 **Recommendation**: Keep current detailed methodology page, but add the simpler overview from greenfield spec as a landing section

### Blog

**Current Site:**
- Simple blog index with article cards
- "Draft" badges for unpublished posts
- Clean, minimal design

**Greenfield Spec:**
- Same approach: cards with title, excerpt, tags, date
- "Draft" badges
- Simple pagination

**Assessment:**
- ✅ Current implementation matches greenfield spec well

### Navigation

**Current Site:**
- Header: CodeMySpec logo, "Methodology", "Blog" links
- Auth links: "Register", "Log in" (top right)
- Footer: CodeMySpec branding

**Greenfield Spec:**
- Header: Logo, nav (Product, Method, Blog, Docs), auth links
- Footer: Copyright, tagline

**Assessment:**
- ⚠️ Current site missing "Docs" link
- ⚠️ Current site missing "Product" link (though homepage serves this purpose)
- ✅ Auth placement is similar

## App Shell Comparison

### Navigation Structure

**Current Site (from login redirect):**
- Top nav: "v1.8.1" logo, navigation items:
  - Accounts
  - Projects
  - Stories
  - Components (with submenu: Components, Scheduler)
  - Content
  - Architecture
- Auth: Register, Log in links

**Greenfield Spec:**
- Sidebar (drawer):
  - Logo + wordmark
  - Primary: Overview, Projects, Stories, Components, Sessions, Architecture, Content
  - Secondary: Settings
- Top bar: Project selector, status badge

**Assessment:**
- ⚠️ Current site uses top navigation (old pattern)
- ✅ Greenfield spec uses sidebar drawer (modern, more space-efficient)
- ⚠️ Current site has "Accounts" and "Scheduler" that aren't in greenfield spec
- ⚠️ Current site missing "Overview" and "Sessions" from greenfield spec
- ⚠️ Current site missing "Settings" (may be elsewhere)

### Routes

**Current Site (observed):**
- `/` - Homepage
- `/methodology` - Methodology page
- `/blog` - Blog index
- `/users/log-in` - Login
- `/users/register` - Register
- `/projects` - Projects (requires auth)
- `/stories` - Stories (requires auth)
- `/components` - Components (requires auth)
- `/content_admin` - Content admin (requires auth)
- `/architecture` - Architecture (requires auth)
- `/accounts` - Accounts (requires auth)

**Greenfield Spec:**
- Marketing: `/`, `/method`, `/docs`, `/blog`, `/log-in`, `/register`
- App: `/app/`, `/app/projects`, `/app/stories`, `/app/components`, `/app/sessions`, `/app/architecture`, `/app/content`, `/app/settings`

**Assessment:**
- ⚠️ Current site uses `/users/log-in` vs. greenfield `/log-in`
- ⚠️ Current site uses `/methodology` vs. greenfield `/method`
- ⚠️ Current site missing `/docs` route
- ⚠️ Current site app routes are at root (`/projects`) vs. greenfield `/app/*` prefix
- ⚠️ Current site missing `/app/` overview route
- ⚠️ Current site missing `/app/sessions` route
- ⚠️ Current site missing `/app/settings` route

## UI/UX Comparison

### Layout System

**Current Site:**
- Appears to use custom layout (not DaisyUI)
- Top navigation bar
- Traditional header/footer structure

**Greenfield Spec:**
- DaisyUI drawer component for app shell
- DaisyUI navbar for marketing header
- Consistent DaisyUI components throughout

**Assessment:**
- ⚠️ Current site likely has custom CSS (what we want to avoid)
- ✅ Greenfield spec uses DaisyUI consistently (easier to maintain)

### Styling Approach

**Current Site:**
- Unknown (can't see full CSS, but appears custom)

**Greenfield Spec:**
- Tailwind + DaisyUI only
- Minimal custom CSS
- Brand colors via Tailwind config

**Assessment:**
- ⚠️ Need to verify current site's CSS approach
- ✅ Greenfield spec is cleaner and more maintainable

## Content Comparison

### Copy Tone

**Current Site:**
- More detailed/verbose
- "Stop drowning in LLM-generated slop" (direct, slightly edgy)
- "AI-Assisted Phoenix Development That Actually Ships" (feature-focused)

**Greenfield Spec:**
- More concise
- "Keep your architecture. Let AI do the typing." (benefit-focused)
- "You stay in charge of the system. The model just fills in the blanks." (reassuring)

**Assessment:**
- ✅ Both have good tone, different approaches
- 💡 **Recommendation**: Test both, but greenfield is more concise (better for scanning)

### Feature Descriptions

**Current Site:**
- Detailed feature descriptions
- Links to deeper content
- Examples from codebase

**Greenfield Spec:**
- Shorter, scannable feature cards
- 2-3 lines per feature
- Less detail, more action-oriented

**Assessment:**
- ✅ Current site better for SEO and deep understanding
- ✅ Greenfield spec better for quick scanning
- 💡 **Recommendation**: Use greenfield structure on homepage, link to detailed pages

## Technical Architecture

### Template System

**Current Site:**
- Unknown (likely older Phoenix patterns)

**Greenfield Spec:**
- Phoenix 1.7+ with `.heex` for everything
- `embed_templates` for layouts
- Auto-discovery (no manual `render/2`)

**Assessment:**
- ⚠️ Current site may have template issues (based on earlier work)
- ✅ Greenfield spec uses modern Phoenix patterns

### Database

**Current Site:**
- Unknown (likely PostgreSQL in production)

**Greenfield Spec:**
- SQLite for development
- PostgreSQL for production
- Clear schema in `02-architecture.md`

**Assessment:**
- ✅ Greenfield spec has clear database strategy

## Key Differences Summary

### What Current Site Has That Greenfield Doesn't:
1. Very detailed methodology page (good for SEO)
2. "Accounts" section in navigation
3. "Scheduler" under Components
4. More verbose copy (good for some users)
5. Examples from actual codebase

### What Greenfield Has That Current Site Doesn't:
1. Sidebar navigation (more modern)
2. `/app/` overview dashboard
3. `/app/sessions` route
4. `/app/settings` route
5. `/docs` route
6. DaisyUI component system
7. Cleaner route structure (`/app/*` prefix)
8. More concise, scannable copy
9. "Why this exists" section
10. "How it works" 3-step flow

## Recommendations

### Keep from Current Site:
1. ✅ Detailed methodology page (but add simpler overview section)
2. ✅ Blog structure
3. ✅ Content depth (but reorganize for scanning)

### Adopt from Greenfield:
1. ✅ Sidebar navigation for app shell
2. ✅ `/app/*` route prefix for clarity
3. ✅ DaisyUI component system
4. ✅ Overview dashboard
5. ✅ Sessions section
6. ✅ More concise homepage copy
7. ✅ "Why this exists" and "How it works" sections
8. ✅ `/docs` route

### Hybrid Approach:
1. 💡 Homepage: Use greenfield structure (scannable) but link to detailed pages
2. 💡 Methodology: Keep detailed version, add greenfield's simpler overview at top
3. 💡 App shell: Use greenfield sidebar, but keep useful features from current (Accounts, Scheduler if needed)
4. 💡 Routes: Use greenfield `/app/*` structure, but map current routes appropriately

## Migration Path

1. **Phase 1**: Build greenfield structure alongside current site
2. **Phase 2**: Migrate content from current site to greenfield structure
3. **Phase 3**: Update routes and navigation
4. **Phase 4**: Switch over completely

Or:

1. **Option A**: Rebuild from scratch using greenfield specs (cleaner, but loses current content)
2. **Option B**: Incrementally refactor current site to match greenfield (keeps content, more work)

## Conclusion

The current site has good content but needs structural improvements. The greenfield spec provides:
- ✅ Modern navigation (sidebar)
- ✅ Cleaner route structure
- ✅ Better component system (DaisyUI)
- ✅ More scannable copy
- ✅ Missing features (Overview, Sessions, Settings)

**Recommendation**: Use greenfield specs as the foundation, but preserve the detailed methodology content from the current site. This gives you the best of both worlds: modern structure + rich content.

