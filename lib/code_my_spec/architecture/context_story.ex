defmodule CodeMySpec.Architecture.ContextStory do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "context_stories" do
    belongs_to :context, CodeMySpec.Architecture.Context
    belongs_to :story, CodeMySpec.Stories.Story

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(context_story, attrs) do
    context_story
    |> cast(attrs, [:context_id, :story_id])
    |> validate_required([:context_id, :story_id])
    |> unique_constraint([:context_id, :story_id])
  end
end

