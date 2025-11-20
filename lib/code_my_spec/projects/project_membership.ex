defmodule CodeMySpec.Projects.ProjectMembership do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "project_memberships" do
    field :role, :string, default: "member"
    belongs_to :project, CodeMySpec.Projects.Project
    belongs_to :user, CodeMySpec.Accounts.Account

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(project_membership, attrs) do
    project_membership
    |> cast(attrs, [:project_id, :user_id, :role])
    |> validate_required([:project_id, :user_id])
    |> unique_constraint([:project_id, :user_id])
  end
end

