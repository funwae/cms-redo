defmodule CodeMySpecWeb.AppLive.Stories do
  use CodeMySpecWeb.AppLive

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Stories", stories: [])}
  end

  def render(assigns) do
    ~H"""
    <div>
      <div class="flex justify-between items-center mb-6">
        <h1 class="text-3xl font-heading font-bold">Stories</h1>
        <button class="btn btn-primary">Create story</button>
      </div>
      <%= if Enum.empty?(@stories) do %>
        <div class="card bg-base-200">
          <div class="card-body text-center">
            <p class="text-base-content/70">No stories yet. Create your first story to get started.</p>
          </div>
        </div>
      <% else %>
        <div class="overflow-x-auto">
          <table class="table">
            <thead>
              <tr>
                <th>Title</th>
                <th>Status</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <%= for story <- @stories do %>
                <tr>
                  <td><%= story.title %></td>
                  <td><span class="badge"><%= story.status %></span></td>
                  <td><a href={~p"/app/stories/#{story.id}"} class="link">View</a></td>
                </tr>
              <% end %>
            </tbody>
          </table>
        </div>
      <% end %>
    </div>
    """
  end
end

