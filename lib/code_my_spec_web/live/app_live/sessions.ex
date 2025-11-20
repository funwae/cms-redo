defmodule CodeMySpecWeb.AppLive.Sessions do
  use CodeMySpecWeb.AppLive

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Sessions", sessions: [])}
  end

  def render(assigns) do
    ~H"""
    <div>
      <div class="flex justify-between items-center mb-6">
        <h1 class="text-3xl font-heading font-bold">Sessions</h1>
        <button class="btn btn-primary">Start session</button>
      </div>
      <%= if Enum.empty?(@sessions) do %>
        <div class="card bg-base-200">
          <div class="card-body text-center">
            <p class="text-base-content/70">No active sessions. Start a design session to begin.</p>
          </div>
        </div>
      <% else %>
        <div class="overflow-x-auto">
          <table class="table">
            <thead>
              <tr>
                <th>Type</th>
                <th>Target</th>
                <th>Status</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <%= for session <- @sessions do %>
                <tr>
                  <td><span class="badge"><%= session.session_type %></span></td>
                  <td><%= session.target_type %></td>
                  <td><span class="badge"><%= session.status %></span></td>
                  <td><a href={~p"/app/sessions/#{session.id}"} class="link">View</a></td>
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

