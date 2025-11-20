defmodule CodeMySpec.Architecture do
  @moduledoc """
  The Architecture context.
  """

  import Ecto.Query, warn: false
  alias CodeMySpec.Repo
  alias CodeMySpec.Architecture.Context
  alias CodeMySpec.Architecture.ContextStory

  @doc """
  Returns the list of contexts for a project.
  """
  def list_contexts(project_id) do
    Repo.all(
      from c in Context,
        where: c.project_id == ^project_id,
        order_by: [asc: c.name]
    )
  end

  @doc """
  Gets a single context.
  """
  def get_context!(id), do: Repo.get!(Context, id) |> Repo.preload(:stories)

  @doc """
  Creates a context.
  """
  def create_context(attrs, project_id) do
    %Context{}
    |> Context.changeset(Map.put(attrs, :project_id, project_id))
    |> Repo.insert()
  end

  @doc """
  Updates a context.
  """
  def update_context(%Context{} = context, attrs) do
    context
    |> Context.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Adds a story to a context.
  """
  def add_story_to_context(context_id, story_id) do
    %ContextStory{}
    |> ContextStory.changeset(%{
      context_id: context_id,
      story_id: story_id
    })
    |> Repo.insert()
  end

  @doc """
  Lists stories for a context.
  """
  def list_stories_for_context(context_id) do
    Repo.all(
      from s in CodeMySpec.Stories.Story,
        join: cs in ContextStory,
        on: cs.story_id == s.id,
        where: cs.context_id == ^context_id
    )
  end
end

