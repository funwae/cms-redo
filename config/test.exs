import Config

config :code_my_spec, CodeMySpec.Repo,
  database: Path.expand("../priv/repo/code_my_spec_test.db", Path.dirname(__ENV__.file)),
  pool_size: 10,
  pool: Ecto.Adapters.SQL.Sandbox

config :code_my_spec, CodeMySpecWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "your-secret-key-base-at-least-64-chars-long-AAAAAAAAAAAAAAAAAAAAAA",
  server: false

config :logger, level: :warning

config :phoenix, :plug_init_mode, :runtime
