defmodule CodeMySpec.Repo.Migrations.CreateContexts do
  use Ecto.Migration

  def change do
    create table(:contexts, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :type, :string, null: false
      add :purpose, :text, null: false
      add :description, :text
      add :approved, :boolean, default: false
      add :dirty, :boolean, default: false
      add :project_id, references(:projects, type: :binary_id, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime_usec)
    end

    create index(:contexts, [:project_id])
  end
end
