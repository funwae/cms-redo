# UI Components Guide (DaisyUI + Tailwind)

## Philosophy

- **DaisyUI first** — Use DaisyUI components wherever possible
- **Tailwind utilities** — Prefer utility classes over custom CSS
- **Minimal custom CSS** — Only for brand colors and essential layout
- **Consistent patterns** — Reuse component patterns across the app

## DaisyUI Components

### Navigation

**Sidebar (Drawer):**
```heex
<div class="drawer lg:drawer-open">
  <input id="drawer-toggle" type="checkbox" class="drawer-toggle" />
  <div class="drawer-content">...</div>
  <div class="drawer-side">
    <aside class="w-64 bg-base-200">
      <ul class="menu p-4">
        <li><a href="/app">Overview</a></li>
      </ul>
    </aside>
  </div>
</div>
```

**Navbar:**
```heex
<div class="navbar bg-base-200">
  <div class="flex-1">
    <a class="btn btn-ghost text-xl">Logo</a>
  </div>
  <div class="flex-none">
    <ul class="menu menu-horizontal px-1">
      <li><a>Item</a></li>
    </ul>
  </div>
</div>
```

### Cards

```heex
<div class="card bg-base-200 shadow-xl">
  <div class="card-body">
    <h2 class="card-title">Title</h2>
    <p>Content</p>
  </div>
</div>
```

### Tables

```heex
<div class="overflow-x-auto">
  <table class="table">
    <thead>
      <tr>
        <th>Name</th>
        <th>Status</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Item</td>
        <td><span class="badge badge-success">Active</span></td>
      </tr>
    </tbody>
  </table>
</div>
```

### Badges

```heex
<span class="badge badge-primary">Primary</span>
<span class="badge badge-secondary">Secondary</span>
<span class="badge badge-success">Success</span>
<span class="badge badge-warning">Warning</span>
<span class="badge badge-error">Error</span>
<span class="badge badge-info">Info</span>
```

### Buttons

```heex
<button class="btn btn-primary">Primary</button>
<button class="btn btn-secondary">Secondary</button>
<button class="btn btn-ghost">Ghost</button>
<button class="btn btn-outline">Outline</button>
```

### Forms

```heex
<div class="form-control">
  <label class="label">
    <span class="label-text">Email</span>
  </label>
  <input type="email" class="input input-bordered" />
</div>

<div class="form-control">
  <label class="label">
    <span class="label-text">Password</span>
  </label>
  <input type="password" class="input input-bordered" />
</div>

<button class="btn btn-primary w-full">Submit</button>
```

### Stats

```heex
<div class="stats stats-vertical lg:stats-horizontal shadow">
  <div class="stat">
    <div class="stat-title">Stories</div>
    <div class="stat-value text-primary">42</div>
    <div class="stat-desc">User stories</div>
  </div>
  <div class="stat">
    <div class="stat-title">Components</div>
    <div class="stat-value text-secondary">18</div>
    <div class="stat-desc">Code components</div>
  </div>
</div>
```

### Tabs

```heex
<div class="tabs">
  <a class="tab tab-active">All</a>
  <a class="tab">Draft</a>
  <a class="tab">Ready</a>
  <a class="tab">Implemented</a>
</div>
```

### Select/Dropdown

```heex
<select class="select select-bordered">
  <option>Option 1</option>
  <option>Option 2</option>
</select>
```

## Brand Colors

Use via Tailwind classes (defined in `tailwind.config.js`):

- `bg-cms-black` / `text-cms-black` — Main background
- `bg-cms-charcoal` / `text-cms-charcoal` — Secondary background
- `bg-cms-orange` / `text-cms-orange` — Primary accent
- `bg-cms-purple` / `text-cms-purple` — Secondary accent
- `bg-cms-aqua` / `text-cms-aqua` — Tertiary accent

Or use DaisyUI theme colors:
- `bg-primary` / `text-primary` — Orange
- `bg-secondary` / `text-secondary` — Purple
- `bg-accent` / `text-accent` — Aqua

## Typography

- **Headings**: `font-heading` (Space Grotesk)
- **Body**: `font-body` (Inter)

```heex
<h1 class="text-3xl font-heading font-bold">Heading</h1>
<p class="text-base font-body">Body text</p>
```

## Spacing

Use Tailwind spacing utilities:
- `p-4` — Padding
- `m-4` — Margin
- `gap-4` — Gap (flex/grid)
- `space-y-4` — Vertical spacing between children

## Responsive Design

Use Tailwind breakpoints:
- `sm:` — 640px+
- `md:` — 768px+
- `lg:` — 1024px+
- `xl:` — 1280px+

Example:
```heex
<div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
  <!-- Responsive grid -->
</div>
```

## Common Patterns

### Empty State

```heex
<div class="card bg-base-200">
  <div class="card-body text-center">
    <p class="text-base-content/70">No items yet.</p>
    <button class="btn btn-primary mt-4">Create your first item</button>
  </div>
</div>
```

### Status Badge

```heex
<%= case @item.status do %>
  <% "active" -> %>
    <span class="badge badge-success">Active</span>
  <% "archived" -> %>
    <span class="badge badge-ghost">Archived</span>
<% end %>
```

### Loading State

```heex
<%= if @loading do %>
  <div class="flex justify-center">
    <span class="loading loading-spinner loading-lg"></span>
  </div>
<% else %>
  <!-- Content -->
<% end %>
```

## What NOT to Do

- ❌ Don't create custom CSS for components that DaisyUI already provides
- ❌ Don't use inline styles — use Tailwind utilities
- ❌ Don't mix custom CSS with DaisyUI (causes conflicts)
- ❌ Don't create custom button styles — use DaisyUI `btn` classes
- ❌ Don't create custom card styles — use DaisyUI `card` classes

## Examples

See `04-app-shell.md` for specific component usage in each screen.

