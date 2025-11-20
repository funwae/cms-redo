defmodule CodeMySpec.Components.Component do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "components" do
    field :name, :string
    field :type, :string
    field :file_path, :string
    field :description, :string
    field :docs_complete, :boolean, default: false
    field :code_complete, :boolean, default: false
    field :tests_complete, :boolean, default: false
    belongs_to :context, CodeMySpec.Architecture.Context
    belongs_to :project, CodeMySpec.Projects.Project
    has_one :design_doc, CodeMySpec.Components.DesignDoc
    has_many :component_dependencies, CodeMySpec.Components.ComponentDependency, foreign_key: :component_id

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(component, attrs) do
    component
    |> cast(attrs, [
      :name,
      :type,
      :file_path,
      :description,
      :docs_complete,
      :code_complete,
      :tests_complete,
      :context_id,
      :project_id
    ])
    |> validate_required([:name, :type, :file_path, :project_id])
  end
end

