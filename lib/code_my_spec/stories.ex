defmodule CodeMySpec.Stories do
  @moduledoc """
  The Stories context.
  """

  import Ecto.Query, warn: false
  alias CodeMySpec.Repo
  alias CodeMySpec.Stories.Story

  @doc """
  Returns the list of stories for a project.
  """
  def list_stories(project_id) do
    Repo.all(
      from s in Story,
        where: s.project_id == ^project_id,
        order_by: [desc: s.inserted_at]
    )
  end

  @doc """
  Gets a single story.
  """
  def get_story!(id), do: Repo.get!(Story, id) |> Repo.preload(:contexts)

  @doc """
  Creates a story.
  """
  def create_story(attrs, project_id) do
    %Story{}
    |> Story.changeset(Map.put(attrs, :project_id, project_id))
    |> Repo.insert()
  end

  @doc """
  Updates a story.
  """
  def update_story(%Story{} = story, attrs) do
    story
    |> Story.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Marks a story as dirty.
  """
  def mark_dirty(%Story{} = story) do
    story
    |> Story.changeset(%{dirty: true})
    |> Repo.update()
  end

  @doc """
  Approves a story.
  """
  def approve(%Story{} = story) do
    story
    |> Story.changeset(%{approved: true})
    |> Repo.update()
  end
end

