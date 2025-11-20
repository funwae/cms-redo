defmodule CodeMySpecWeb.Plugs.Auth do
  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    # STUB: For demo, always allow
    user_id = get_session(conn, :user_id) || Ecto.UUID.generate()
    put_session(conn, :user_id, user_id)
  end
end

