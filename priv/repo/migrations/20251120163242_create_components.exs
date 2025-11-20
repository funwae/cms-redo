defmodule CodeMySpec.Repo.Migrations.CreateComponents do
  use Ecto.Migration

  def change do
    create table(:components, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string, null: false
      add :type, :string, null: false
      add :file_path, :string, null: false
      add :description, :text
      add :docs_complete, :boolean, default: false
      add :code_complete, :boolean, default: false
      add :tests_complete, :boolean, default: false
      add :context_id, references(:contexts, type: :binary_id, on_delete: :nilify_all)
      add :project_id, references(:projects, type: :binary_id, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime_usec)
    end

    create index(:components, [:context_id])
    create index(:components, [:project_id])
  end
end
