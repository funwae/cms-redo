defmodule CodeMySpec.Repo.Migrations.CreateComponentDependencies do
  use Ecto.Migration

  def change do
    create table(:component_dependencies, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :component_id, references(:components, type: :binary_id, on_delete: :delete_all), null: false
      add :depends_on_id, references(:components, type: :binary_id, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime_usec)
    end

    create index(:component_dependencies, [:component_id])
    create index(:component_dependencies, [:depends_on_id])
    create unique_index(:component_dependencies, [:component_id, :depends_on_id])
  end
end
