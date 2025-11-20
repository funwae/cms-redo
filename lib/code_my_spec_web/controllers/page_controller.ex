defmodule CodeMySpecWeb.PageController do
  use CodeMySpecWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end

  def method(conn, _params) do
    render(conn, :method)
  end

  def docs(conn, _params) do
    render(conn, :docs)
  end
end

