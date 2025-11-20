import Config

config :code_my_spec, CodeMySpec.Repo,
  database: Path.expand("../priv/repo/code_my_spec_dev.db", Path.dirname(__ENV__.file)),
  pool_size: 10,
  show_sensitive_data_on_connection_error: true

config :code_my_spec, CodeMySpecWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "your-secret-key-base-at-least-64-chars-long-AAAAAAAAAAAAAAAAAAAAAA",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:code_my_spec, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:code_my_spec, ~w(--watch)]}
  ]

config :code_my_spec, CodeMySpecWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/code_my_spec_web/(controllers|live|components)/.*(ex|heex)$",
      ~r"lib/code_my_spec_web/templates/.*(ex|heex)$",
      ~r"lib/code_my_spec_web/layouts/.*(ex|heex)$"
    ]
  ]

config :logger, :console, format: "[$level] $message\n"

config :phoenix, :stacktrace_depth, 20

config :phoenix, :plug_init_mode, :runtime
