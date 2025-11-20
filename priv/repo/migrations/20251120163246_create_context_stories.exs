defmodule CodeMySpec.Repo.Migrations.CreateContextStories do
  use Ecto.Migration

  def change do
    create table(:context_stories, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :context_id, references(:contexts, type: :binary_id, on_delete: :delete_all), null: false
      add :story_id, references(:stories, type: :binary_id, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime_usec)
    end

    create index(:context_stories, [:context_id])
    create index(:context_stories, [:story_id])
    create unique_index(:context_stories, [:context_id, :story_id])
  end
end
