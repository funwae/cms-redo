defmodule CodeMySpecWeb.AppLive.Content do
  use CodeMySpecWeb.AppLive

  def mount(_params, _session, socket) do
    {:ok, assign(socket, page_title: "Content")}
  end

  def render(assigns) do
    ~H"""
    <div>
      <h1 class="text-3xl font-heading font-bold mb-6">Content</h1>
      <div class="card bg-base-200">
        <div class="card-body">
          <p class="text-base-content/70">Content management coming soon.</p>
        </div>
      </div>
    </div>
    """
  end
end

