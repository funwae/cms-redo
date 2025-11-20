# Architecture & Data Model

## Database Schema

### Core Tables

#### accounts
- `id` (UUID, primary key)
- `email` (string, unique, indexed)
- `hashed_password` (string)
- `name` (string, nullable)
- `inserted_at`, `updated_at` (timestamps)

#### projects
- `id` (UUID, primary key)
- `name` (string)
- `description` (text, nullable)
- `github_repo_url` (string, nullable)
- `github_repo_name` (string, nullable)
- `framework` (string, default: "phoenix")
- `status` (enum: `active`, `archived`)
- `executive_summary` (text, nullable)
- `executive_summary_approved` (boolean, default: false)
- `setup_complete` (boolean, default: false)
- `context_mapping_approved` (boolean, default: false)
- `owner_id` → `accounts.id` (foreign key, indexed)
- `inserted_at`, `updated_at` (timestamps)

#### project_memberships
- `id` (UUID, primary key)
- `project_id` → `projects.id` (indexed)
- `user_id` → `accounts.id` (indexed)
- `role` (string, default: "member")
- `inserted_at`, `updated_at` (timestamps)
- Unique constraint: `(project_id, user_id)`

#### stories
- `id` (UUID, primary key)
- `title` (string)
- `description` (text)
- `acceptance_criteria` (text, nullable)
- `status` (enum: `draft`, `ready`, `implemented`)
- `dirty` (boolean, default: false)
- `approved` (boolean, default: false)
- `version` (integer, default: 1)
- `project_id` → `projects.id` (indexed)
- `inserted_at`, `updated_at` (timestamps)

#### contexts
- `id` (UUID, primary key)
- `name` (string) — e.g., "Accounts", "Billing", "Orders"
- `type` (enum: `domain`, `coordination`)
- `purpose` (text)
- `description` (text, nullable)
- `approved` (boolean, default: false)
- `dirty` (boolean, default: false)
- `project_id` → `projects.id` (indexed)
- `inserted_at`, `updated_at` (timestamps)

#### context_stories
- `id` (UUID, primary key)
- `context_id` → `contexts.id` (indexed)
- `story_id` → `stories.id` (indexed)
- `inserted_at`, `updated_at` (timestamps)
- Unique constraint: `(context_id, story_id)`

#### components
- `id` (UUID, primary key)
- `name` (string) — e.g., "Accounts.User", "Orders.LiveView"
- `type` (enum: `context`, `schema`, `controller`, `liveview`, `genserver`, `task`, `other`)
- `file_path` (string) — relative path in repo
- `description` (text, nullable)
- `docs_complete` (boolean, default: false)
- `code_complete` (boolean, default: false)
- `tests_complete` (boolean, default: false)
- `context_id` → `contexts.id` (indexed, nullable)
- `project_id` → `projects.id` (indexed)
- `inserted_at`, `updated_at` (timestamps)

#### component_dependencies
- `id` (UUID, primary key)
- `component_id` → `components.id` (indexed)
- `depends_on_id` → `components.id` (indexed)
- `inserted_at`, `updated_at` (timestamps)
- Unique constraint: `(component_id, depends_on_id)`

#### design_docs
- `id` (UUID, primary key)
- `component_id` → `components.id` (indexed, unique)
- `content` (text) — markdown content
- `approved` (boolean, default: false)
- `version` (integer, default: 1)
- `inserted_at`, `updated_at` (timestamps)

#### sessions
- `id` (UUID, primary key)
- `session_type` (enum: `design`, `test`, `implementation`, `setup`)
- `target_type` (string) — "component", "context", "project"
- `target_id` (UUID) — ID of target entity
- `status` (enum: `pending`, `in_progress`, `complete`, `failed`)
- `project_id` → `projects.id` (indexed)
- `inserted_at`, `updated_at` (timestamps)

## Phoenix Contexts

### CodeMySpec.Accounts
- `create_user/1`
- `get_user!/1`
- `get_user_by_email/1`
- `authenticate_user/2`

### CodeMySpec.Projects
- `list_projects/1` (by user_id)
- `get_project!/1`
- `create_project/2` (attrs, user_id)
- `update_project/2`
- `add_member/3` (project_id, user_id, role)
- `user_has_access?/2`

### CodeMySpec.Stories
- `list_stories/1` (project_id)
- `get_story!/1`
- `create_story/2` (attrs, project_id)
- `update_story/2`
- `mark_dirty/1`
- `approve/1`

### CodeMySpec.Architecture
- `list_contexts/1` (project_id)
- `get_context!/1`
- `create_context/2` (attrs, project_id)
- `update_context/2`
- `add_story_to_context/2` (context_id, story_id)
- `list_stories_for_context/1`

### CodeMySpec.Components
- `list_components/1` (project_id)
- `get_component!/1`
- `create_component/2` (attrs, project_id)
- `update_component/2`
- `add_dependency/2` (component_id, depends_on_id)
- `list_dependencies/1`
- `update_status/2` (component_id, status_map)

### CodeMySpec.Sessions
- `list_sessions/1` (project_id)
- `get_session!/1`
- `create_session/2` (attrs, project_id)
- `update_status/2` (session_id, status)
- `list_active_sessions/1`

## Key Relationships

```
Project
├── Stories (many)
├── Contexts (many)
│   └── ContextStories (many-to-many with Stories)
├── Components (many)
│   ├── DesignDocs (1:1)
│   └── ComponentDependencies (many-to-many)
└── Sessions (many)
```

## Status Fields & Workflow

- **Stories**: `draft` → `ready` → `implemented`
- **Contexts**: `approved` flag for architect sign-off
- **Components**: `docs_complete`, `code_complete`, `tests_complete` flags
- **Sessions**: `pending` → `in_progress` → `complete` / `failed`
- **Dirty flags**: Mark entities that need regeneration when dependencies change

## Indexes

- All foreign keys indexed
- `projects.owner_id` indexed
- `stories.project_id` indexed
- `contexts.project_id` indexed
- `components.project_id` and `components.context_id` indexed
- `sessions.project_id` indexed
- Unique constraints on join tables

