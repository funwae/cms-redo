defmodule CodeMySpec.Repo.Migrations.CreateStories do
  use Ecto.Migration

  def change do
    create table(:stories, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :title, :string, null: false
      add :description, :text, null: false
      add :acceptance_criteria, :text
      add :status, :string, default: "draft"
      add :dirty, :boolean, default: false
      add :approved, :boolean, default: false
      add :version, :integer, default: 1
      add :project_id, references(:projects, type: :binary_id, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime_usec)
    end

    create index(:stories, [:project_id])
  end
end
