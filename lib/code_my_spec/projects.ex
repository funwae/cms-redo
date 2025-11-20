defmodule CodeMySpec.Projects do
  @moduledoc """
  The Projects context.
  """

  import Ecto.Query, warn: false
  alias CodeMySpec.Repo
  alias CodeMySpec.Projects.Project
  alias CodeMySpec.Projects.ProjectMembership

  @doc """
  Returns the list of projects for a user.
  """
  def list_projects(user_id) do
    Repo.all(
      from p in Project,
        where: p.owner_id == ^user_id or
               p.id in subquery(
                 from pm in ProjectMembership,
                   where: pm.user_id == ^user_id,
                   select: pm.project_id
               )
    )
  end

  @doc """
  Gets a single project.
  """
  def get_project!(id), do: Repo.get!(Project, id)

  @doc """
  Creates a project.
  """
  def create_project(attrs, user_id) do
    %Project{}
    |> Project.changeset(Map.put(attrs, :owner_id, user_id))
    |> Repo.insert()
  end

  @doc """
  Updates a project.
  """
  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Adds a member to a project.
  """
  def add_member(project_id, user_id, role \\ "member") do
    %ProjectMembership{}
    |> ProjectMembership.changeset(%{
      project_id: project_id,
      user_id: user_id,
      role: role
    })
    |> Repo.insert()
  end

  @doc """
  Checks if a user has access to a project.
  """
  def user_has_access?(project_id, user_id) do
    project = Repo.get(Project, project_id)

    if project && (project.owner_id == user_id) do
      true
    else
      Repo.exists?(
        from pm in ProjectMembership,
          where: pm.project_id == ^project_id and pm.user_id == ^user_id
      )
    end
  end
end

