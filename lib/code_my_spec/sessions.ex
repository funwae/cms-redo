defmodule CodeMySpec.Sessions do
  @moduledoc """
  The Sessions context.
  """

  import Ecto.Query, warn: false
  alias CodeMySpec.Repo
  alias CodeMySpec.Sessions.Session

  @doc """
  Returns the list of sessions for a project.
  """
  def list_sessions(project_id) do
    Repo.all(
      from s in Session,
        where: s.project_id == ^project_id,
        order_by: [desc: s.inserted_at]
    )
  end

  @doc """
  Gets a single session.
  """
  def get_session!(id), do: Repo.get!(Session, id)

  @doc """
  Creates a session.
  """
  def create_session(attrs, project_id) do
    %Session{}
    |> Session.changeset(Map.put(attrs, :project_id, project_id))
    |> Repo.insert()
  end

  @doc """
  Updates session status.
  """
  def update_status(session_id, status) do
    session = Repo.get!(Session, session_id)

    session
    |> Session.changeset(%{status: status})
    |> Repo.update()
  end

  @doc """
  Lists active sessions for a project.
  """
  def list_active_sessions(project_id) do
    Repo.all(
      from s in Session,
        where: s.project_id == ^project_id and s.status == "in_progress",
        order_by: [desc: s.inserted_at]
    )
  end
end

