defmodule CodeMySpec.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :description, :text
      add :github_repo_url, :string
      add :github_repo_name, :string
      add :framework, :string, default: "phoenix"
      add :status, :string, default: "active"
      add :executive_summary, :text
      add :executive_summary_approved, :boolean, default: false
      add :setup_complete, :boolean, default: false
      add :context_mapping_approved, :boolean, default: false
      add :owner_id, references(:accounts, type: :binary_id, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime_usec)
    end

    create index(:projects, [:owner_id])
  end
end
