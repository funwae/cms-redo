defmodule CodeMySpec.Sessions.Session do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id

  schema "sessions" do
    field :session_type, :string
    field :target_type, :string
    field :target_id, :binary_id
    field :status, :string, default: "pending"
    belongs_to :project, CodeMySpec.Projects.Project

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [
      :session_type,
      :target_type,
      :target_id,
      :status,
      :project_id
    ])
    |> validate_required([:session_type, :target_type, :target_id, :project_id])
  end
end

