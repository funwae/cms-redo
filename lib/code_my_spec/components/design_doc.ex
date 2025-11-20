defmodule CodeMySpec.Components.DesignDoc do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "design_docs" do
    field :content, :string
    field :approved, :boolean, default: false
    field :version, :integer, default: 1
    belongs_to :component, CodeMySpec.Components.Component

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(design_doc, attrs) do
    design_doc
    |> cast(attrs, [:component_id, :content, :approved, :version])
    |> validate_required([:component_id, :content])
    |> unique_constraint(:component_id)
  end
end

