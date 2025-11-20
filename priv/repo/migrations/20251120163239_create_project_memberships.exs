defmodule CodeMySpec.Repo.Migrations.CreateProjectMemberships do
  use Ecto.Migration

  def change do
    create table(:project_memberships, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :project_id, references(:projects, type: :binary_id, on_delete: :delete_all), null: false
      add :user_id, references(:accounts, type: :binary_id, on_delete: :delete_all), null: false
      add :role, :string, default: "member"

      timestamps(type: :utc_datetime_usec)
    end

    create index(:project_memberships, [:project_id])
    create index(:project_memberships, [:user_id])
    create unique_index(:project_memberships, [:project_id, :user_id])
  end
end
