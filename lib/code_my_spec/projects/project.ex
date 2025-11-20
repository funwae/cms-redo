defmodule CodeMySpec.Projects.Project do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "projects" do
    field :name, :string
    field :description, :string
    field :github_repo_url, :string
    field :github_repo_name, :string
    field :framework, :string, default: "phoenix"
    field :status, :string, default: "active"
    field :executive_summary, :string
    field :executive_summary_approved, :boolean, default: false
    field :setup_complete, :boolean, default: false
    field :context_mapping_approved, :boolean, default: false
    belongs_to :owner, CodeMySpec.Accounts.Account
    has_many :project_memberships, CodeMySpec.Projects.ProjectMembership
    has_many :stories, CodeMySpec.Stories.Story
    has_many :contexts, CodeMySpec.Architecture.Context
    has_many :components, CodeMySpec.Components.Component
    has_many :sessions, CodeMySpec.Sessions.Session

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [
      :name,
      :description,
      :github_repo_url,
      :github_repo_name,
      :framework,
      :status,
      :executive_summary,
      :executive_summary_approved,
      :setup_complete,
      :context_mapping_approved,
      :owner_id
    ])
    |> validate_required([:name, :owner_id])
  end
end

