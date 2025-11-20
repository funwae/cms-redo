defmodule CodeMySpec.Components do
  @moduledoc """
  The Components context.
  """

  import Ecto.Query, warn: false
  alias CodeMySpec.Repo
  alias CodeMySpec.Components.Component
  alias CodeMySpec.Components.ComponentDependency
  alias CodeMySpec.Components.DesignDoc

  @doc """
  Returns the list of components for a project.
  """
  def list_components(project_id) do
    Repo.all(
      from c in Component,
        where: c.project_id == ^project_id,
        order_by: [asc: c.name]
    )
  end

  @doc """
  Gets a single component.
  """
  def get_component!(id) do
    Repo.get!(Component, id)
    |> Repo.preload([:design_doc, :component_dependencies])
  end

  @doc """
  Creates a component.
  """
  def create_component(attrs, project_id) do
    %Component{}
    |> Component.changeset(Map.put(attrs, :project_id, project_id))
    |> Repo.insert()
  end

  @doc """
  Updates a component.
  """
  def update_component(%Component{} = component, attrs) do
    component
    |> Component.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Adds a dependency to a component.
  """
  def add_dependency(component_id, depends_on_id) do
    %ComponentDependency{}
    |> ComponentDependency.changeset(%{
      component_id: component_id,
      depends_on_id: depends_on_id
    })
    |> Repo.insert()
  end

  @doc """
  Lists dependencies for a component.
  """
  def list_dependencies(component_id) do
    Repo.all(
      from cd in ComponentDependency,
        where: cd.component_id == ^component_id,
        preload: [:depends_on]
    )
  end

  @doc """
  Updates component status flags.
  """
  def update_status(component_id, status_map) do
    component = Repo.get!(Component, component_id)

    component
    |> Component.changeset(status_map)
    |> Repo.update()
  end
end

