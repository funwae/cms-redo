defmodule CodeMySpec.Release do
  @moduledoc """
  Used for executing DB release tasks when run in production without Mix
  installed.
  """
  @app :code_my_spec

  def migrate do
    load_app()

    for repo <- repos() do
      case Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true)) do
        {:ok, _, _} ->
          :ok
        {:error, error} ->
          IO.puts(:stderr, """
          ⚠️  WARNING: Database migrations failed. The app will start anyway for preview.
          Error: #{inspect(error)}
          
          This is OK for preview deployments. Set up your database to enable full functionality.
          """)
          :ok
      end
    end
  end

  def rollback(repo, version) do
    load_app()
    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.fetch_env!(@app, :ecto_repos)
  end

  defp load_app do
    Application.load(@app)
  end
end

