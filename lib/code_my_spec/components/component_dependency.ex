defmodule CodeMySpec.Components.ComponentDependency do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "component_dependencies" do
    belongs_to :component, CodeMySpec.Components.Component, foreign_key: :component_id
    belongs_to :depends_on, CodeMySpec.Components.Component, foreign_key: :depends_on_id

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(component_dependency, attrs) do
    component_dependency
    |> cast(attrs, [:component_id, :depends_on_id])
    |> validate_required([:component_id, :depends_on_id])
    |> unique_constraint([:component_id, :depends_on_id])
  end
end

