defmodule CodeMySpec.Repo.Migrations.CreateDesignDocs do
  use Ecto.Migration

  def change do
    create table(:design_docs, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :component_id, references(:components, type: :binary_id, on_delete: :delete_all), null: false
      add :content, :text, null: false
      add :approved, :boolean, default: false
      add :version, :integer, default: 1

      timestamps(type: :utc_datetime_usec)
    end

    create unique_index(:design_docs, [:component_id])
  end
end
