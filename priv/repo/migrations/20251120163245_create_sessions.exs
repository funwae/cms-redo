defmodule CodeMySpec.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :session_type, :string, null: false
      add :target_type, :string, null: false
      add :target_id, :binary_id, null: false
      add :status, :string, default: "pending"
      add :project_id, references(:projects, type: :binary_id, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime_usec)
    end

    create index(:sessions, [:project_id])
  end
end
