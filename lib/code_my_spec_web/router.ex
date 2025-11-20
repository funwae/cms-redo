defmodule CodeMySpecWeb.Router do
  use CodeMySpecWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CodeMySpecWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :marketing_layout do
    plug :put_layout, html: {CodeMySpecWeb.Layouts, :marketing}
  end

  pipeline :auth do
    plug CodeMySpecWeb.Plugs.Auth
  end

  scope "/", CodeMySpecWeb do
    pipe_through [:browser, :marketing_layout]

    get "/", PageController, :home
    get "/method", PageController, :method
    get "/docs", PageController, :docs
    get "/log-in", AuthController, :login
    post "/log-in", AuthController, :create
    get "/register", AuthController, :register
    post "/register", AuthController, :register_user
  end

  pipeline :app_layout do
    plug :put_layout, html: {CodeMySpecWeb.Layouts, :app}
  end

  scope "/app", CodeMySpecWeb do
    pipe_through [:browser, :auth, :app_layout]

    live "/", AppLive.Overview
    live "/projects", AppLive.Projects
    live "/projects/:id", AppLive.ProjectDetail
    live "/stories", AppLive.Stories
    live "/stories/:id", AppLive.StoryDetail
    live "/components", AppLive.Components
    live "/components/:id", AppLive.ComponentDetail
    live "/sessions", AppLive.Sessions
    live "/sessions/:id", AppLive.SessionDetail
    live "/architecture", AppLive.Architecture
    live "/content", AppLive.Content
    live "/settings", AppLive.Settings
  end
end
