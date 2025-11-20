defmodule CodeMySpecWeb.AppLive.Architecture do
  use CodeMySpecWeb.AppLive

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Architecture", contexts: [])}
  end

  def render(assigns) do
    ~H"""
    <div>
      <div class="flex justify-between items-center mb-6">
        <h1 class="text-3xl font-heading font-bold">Architecture</h1>
        <button class="btn btn-primary">Add context</button>
      </div>
      <%= if Enum.empty?(@contexts) do %>
        <div class="card bg-base-200">
          <div class="card-body text-center">
            <p class="text-base-content/70">No contexts yet. Import from docs/architecture.md or add a context manually.</p>
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
              <%= for context <- @contexts do %>
                <tr>
                  <td><%= context.name %></td>
                  <td><span class="badge"><%= context.type %></span></td>
                  <td>
                    <%= if context.approved do %>
                      <span class="badge badge-success">Approved</span>
                    <% else %>
                      <span class="badge badge-warning">Needs review</span>
                    <% end %>
                  </td>
                  <td><a href="#" class="link">View</a></td>
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

