defmodule CodeMySpecWeb.AppLive.SessionDetail do
  use CodeMySpecWeb.AppLive

  def mount(%{"id" => id}, _session, socket) do
    {:ok, assign(socket, page_title: "Session", session_id: id, session: nil)}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1 class="text-3xl font-heading font-bold mb-6">Session Details</h1>
      <%= if @session do %>
        <div class="card bg-base-200">
          <div class="card-body">
            <h2 class="card-title"><%= @session.session_type %></h2>
            <p>Status: <span class="badge"><%= @session.status %></span></p>
          </div>
        </div>
      <% else %>
        <p>Session not found.</p>
      <% end %>
    </div>
    """
  end
end

