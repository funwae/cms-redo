defmodule CodeMySpecWeb.AppLive.Projects do
  use CodeMySpecWeb.AppLive

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Projects", projects: [])}
  end

  def render(assigns) do
    ~H"""
    <div>
      <div class="flex justify-between items-center mb-6">
        <h1 class="text-3xl font-heading font-bold">Projects</h1>
        <button class="btn btn-primary">Create project</button>
      </div>
      <%= if Enum.empty?(@projects) do %>
        <div class="card bg-base-200">
          <div class="card-body text-center">
            <p class="text-base-content/70">No project yet. Create a project to get started.</p>
          </div>
        </div>
      <% else %>
        <div class="overflow-x-auto">
          <table class="table">
            <thead>
              <tr>
                <th>Name</th>
                <th>Status</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <%= for project <- @projects do %>
                <tr>
                  <td><%= project.name %></td>
                  <td><span class="badge badge-success"><%= project.status %></span></td>
                  <td><a href={~p"/app/projects/#{project.id}"} class="link">View</a></td>
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

