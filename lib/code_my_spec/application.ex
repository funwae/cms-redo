defmodule CodeMySpec.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      CodeMySpec.Repo,
      {Phoenix.PubSub, name: CodeMySpec.PubSub},
      CodeMySpecWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: CodeMySpec.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    CodeMySpecWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
