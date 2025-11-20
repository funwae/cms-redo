defmodule CodeMySpec.Stories.Story do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "stories" do
    field :title, :string
    field :description, :string
    field :acceptance_criteria, :string
    field :status, :string, default: "draft"
    field :dirty, :boolean, default: false
    field :approved, :boolean, default: false
    field :version, :integer, default: 1
    belongs_to :project, CodeMySpec.Projects.Project
    many_to_many :contexts, CodeMySpec.Architecture.Context, join_through: CodeMySpec.Architecture.ContextStory

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(story, attrs) do
    story
    |> cast(attrs, [
      :title,
      :description,
      :acceptance_criteria,
      :status,
      :dirty,
      :approved,
      :version,
      :project_id
    ])
    |> validate_required([:title, :description, :project_id])
  end
end

