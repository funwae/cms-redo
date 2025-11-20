defmodule CodeMySpecWeb.AuthController do
  use CodeMySpecWeb, :controller

  def login(conn, _params) do
    render(conn, :login)
  end

  def register(conn, _params) do
    render(conn, :register)
  end

  def create(conn, _params) do
    # STUB: Set session and redirect
    conn
    |> put_session(:user_id, Ecto.UUID.generate())
    |> redirect(to: ~p"/app")
  end

  def register_user(conn, _params) do
    # STUB: Create user, set session, redirect
    conn
    |> put_session(:user_id, Ecto.UUID.generate())
    |> redirect(to: ~p"/app")
  end
end

