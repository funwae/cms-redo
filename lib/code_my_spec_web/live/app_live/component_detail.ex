defmodule CodeMySpecWeb.AppLive.ComponentDetail do
  use CodeMySpecWeb.AppLive

  def mount(%{"id" => id}, _session, socket) do
    {:ok, assign(socket, page_title: "Component", component_id: id, component: nil)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1 class="text-3xl font-heading font-bold mb-6">Component Details</h1>
      <%= if @component do %>
        <div class="card bg-base-200">
          <div class="card-body">
            <h2 class="card-title"><%= @component.name %></h2>
            <p><%= @component.description || "No description" %></p>
          </div>
        </div>
      <% else %>
        <p>Component not found.</p>
      <% end %>
    </div>
    """
  end
end

