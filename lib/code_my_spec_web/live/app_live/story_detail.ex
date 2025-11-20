defmodule CodeMySpecWeb.AppLive.StoryDetail do
  use CodeMySpecWeb.AppLive

  def mount(%{"id" => id}, _session, socket) do
    {:ok, assign(socket, page_title: "Story", story_id: id, story: nil)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1 class="text-3xl font-heading font-bold mb-6">Story Details</h1>
      <%= if @story do %>
        <div class="card bg-base-200">
          <div class="card-body">
            <h2 class="card-title"><%= @story.title %></h2>
            <p><%= @story.description %></p>
          </div>
        </div>
      <% else %>
        <p>Story not found.</p>
      <% end %>
    </div>
    """
  end
end

