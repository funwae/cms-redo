alias CodeMySpec.{Accounts, Projects, Stories, Architecture, Components, Sessions}
alias CodeMySpec.Repo

# Create test user
user = Accounts.create_user!(%{
  email: "test@example.com",
  name: "Test User",
  hashed_password: "stub"
})

# Create test project
{:ok, project} = Projects.create_project(%{
  name: "Test Project",
  description: "A test project for CodeMySpec",
  framework: "phoenix"
}, user.id)

# Create test stories
{:ok, story1} = Stories.create_story(%{
  title: "User can log in",
  description: "As a user, I want to log in so I can access my account.",
  acceptance_criteria: "User can enter email and password, and be authenticated",
  status: "ready"
}, project.id)

{:ok, _story2} = Stories.create_story(%{
  title: "User can create a project",
  description: "As a user, I want to create a project so I can organize my work.",
  status: "draft"
}, project.id)

# Create test context
{:ok, context} = Architecture.create_context(%{
  name: "Accounts",
  type: "domain",
  purpose: "Handles user authentication and account management",
  description: "Manages user accounts, authentication, and authorization"
}, project.id)

# Link story to context
Architecture.add_story_to_context(context.id, story1.id)

# Create test component
{:ok, component} = Components.create_component(%{
  name: "Accounts.User",
  type: "schema",
  file_path: "lib/code_my_spec/accounts/user.ex",
  description: "User schema for authentication"
}, project.id)

# Create design doc for component
alias CodeMySpec.Components.DesignDoc
Repo.insert!(%DesignDoc{
  component_id: component.id,
  content: "# Accounts.User\n\nSchema for user accounts.\n\n## Fields\n\n- email: string\n- hashed_password: string\n- name: string (optional)",
  approved: false,
  version: 1
})

# Create test session
{:ok, _session} = Sessions.create_session(%{
  session_type: "design",
  target_type: "component",
  target_id: component.id,
  status: "complete"
}, project.id)

IO.puts("Seed data created successfully!")
IO.puts("User: #{user.email}")
IO.puts("Project: #{project.name}")
IO.puts("Stories: #{Repo.aggregate(Stories.Story, :count, :id)}")
IO.puts("Contexts: #{Repo.aggregate(Architecture.Context, :count, :id)}")
IO.puts("Components: #{Repo.aggregate(Components.Component, :count, :id)}")

