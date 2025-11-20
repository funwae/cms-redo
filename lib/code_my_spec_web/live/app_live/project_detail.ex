defmodule CodeMySpecWeb.AppLive.ProjectDetail do
  use CodeMySpecWeb.AppLive

  def mount(%{"id" => id}, _session, socket) do
    {:ok, assign(socket, page_title: "Project", project_id: id, project: nil)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1 class="text-3xl font-heading font-bold mb-6">Project Details</h1>
      <%= if @project do %>
        <div class="card bg-base-200">
          <div class="card-body">
            <h2 class="card-title"><%= @project.name %></h2>
            <p><%= @project.description || "No description" %></p>
          </div>
        </div>
      <% else %>
        <p>Project not found.</p>
      <% end %>
    </div>
    """
  end
end

