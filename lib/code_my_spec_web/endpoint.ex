defmodule CodeMySpecWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :code_my_spec

  # Get signing_salt from config or use default
  @signing_salt Application.get_env(:code_my_spec, CodeMySpecWeb.Endpoint)[:signing_salt] ||
                Application.get_env(:code_my_spec, CodeMySpecWeb.Endpoint)[:live_view][:signing_salt] ||
                "your-secret-signing-salt"

  socket "/live", Phoenix.LiveView.Socket,
    websocket: [connect_info: [session: [
      store: :cookie,
      key: "_code_my_spec_key",
      same_site: "Lax",
      signing_salt: @signing_salt
    ]]],
    longpoll: false

  # Code reloading for development only
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.Static,
    at: "/",
    from: :code_my_spec,
    gzip: false,
    only: CodeMySpecWeb.static_paths()

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  
  # Session plug
  plug Plug.Session,
    store: :cookie,
    key: "_code_my_spec_key",
    same_site: "Lax",
    signing_salt: @signing_salt
  
  plug CodeMySpecWeb.Router
end
