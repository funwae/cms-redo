defmodule CodeMySpecWeb.AppLive.Components do
  use CodeMySpecWeb.AppLive

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Components", components: [])}
  end

  def render(assigns) do
    ~H"""
    <div>
      <div class="flex justify-between items-center mb-6">
        <h1 class="text-3xl font-heading font-bold">Components</h1>
        <button class="btn btn-primary">Add component</button>
      </div>
      <%= if Enum.empty?(@components) do %>
        <div class="card bg-base-200">
          <div class="card-body text-center">
            <p class="text-base-content/70">No components yet.</p>
          </div>
        </div>
      <% else %>
        <div class="overflow-x-auto">
          <table class="table">
            <thead>
              <tr>
                <th>Name</th>
                <th>Type</th>
                <th>Status</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <%= for component <- @components do %>
                <tr>
                  <td><%= component.name %></td>
                  <td><span class="badge"><%= component.type %></span></td>
                  <td>
                    <%= if component.docs_complete && component.code_complete && component.tests_complete do %>
                      <span class="badge badge-success">Complete</span>
                    <% else %>
                      <span class="badge badge-warning">In progress</span>
                    <% end %>
                  </td>
                  <td><a href={~p"/app/components/#{component.id}"} class="link">View</a></td>
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

