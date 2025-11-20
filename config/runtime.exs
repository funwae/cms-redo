import Config

if config_env() == :prod do
  # Support both DATABASE_PATH (SQLite) and DATABASE_URL (PostgreSQL)
  database_path = System.get_env("DATABASE_PATH")
  database_url = System.get_env("DATABASE_URL")

  if database_url do
    # PostgreSQL configuration
    config :code_my_spec, CodeMySpec.Repo,
      url: database_url,
      pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
  else
    # SQLite configuration (fallback)
    database_path =
      database_path ||
        (if fly_volume = System.get_env("FLY_VOLUME_MOUNT_PATH"), do: Path.join(fly_volume, "code_my_spec_prod.db")) ||
        System.get_env("RENDER_PROJECT_PATH") && Path.join(System.get_env("RENDER_PROJECT_PATH"), "priv/repo/code_my_spec_prod.db") ||
        "/opt/render/project/priv/repo/code_my_spec_prod.db" ||
        "/tmp/code_my_spec_prod.db" ||
        raise """
        environment variable DATABASE_PATH is missing.
        For example: /opt/render/project/priv/repo/code_my_spec_prod.db
        Or set DATABASE_URL for PostgreSQL.
        """

    config :code_my_spec, CodeMySpec.Repo,
      database: database_path,
      pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")
  end

  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  host = System.get_env("PHX_HOST") || "example.com"
  port = String.to_integer(System.get_env("PORT") || "4000")

  signing_salt = System.get_env("SIGNING_SALT") || Base.encode64(:crypto.strong_rand_bytes(16))

  config :code_my_spec, CodeMySpecWeb.Endpoint,
    url: [host: host, port: 443, scheme: "https"],
    http: [
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: port
    ],
    secret_key_base: secret_key_base,
    signing_salt: signing_salt,
    live_view: [signing_salt: signing_salt]
end
