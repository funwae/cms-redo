defmodule CodeMySpec.Architecture.Context do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "contexts" do
    field :name, :string
    field :type, :string
    field :purpose, :string
    field :description, :string
    field :approved, :boolean, default: false
    field :dirty, :boolean, default: false
    belongs_to :project, CodeMySpec.Projects.Project
    many_to_many :stories, CodeMySpec.Stories.Story, join_through: CodeMySpec.Architecture.ContextStory
    has_many :components, CodeMySpec.Components.Component

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(context, attrs) do
    context
    |> cast(attrs, [
      :name,
      :type,
      :purpose,
      :description,
      :approved,
      :dirty,
      :project_id
    ])
    |> validate_required([:name, :type, :purpose, :project_id])
  end
end

