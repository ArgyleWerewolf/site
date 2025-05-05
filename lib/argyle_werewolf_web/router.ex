defmodule ArgyleWerewolfWeb.Router do
  use ArgyleWerewolfWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {ArgyleWerewolfWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ArgyleWerewolfWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/lycanthropy-thesis-questions/", PageController, :ltq

    scope "/code" do
      get "/", PageController, :code
      get "/sprites/", PageController, :sprites
    end

    scope "/writing" do
      get "/", PageController, :writing
    end

    scope "/design" do
      get "/", PageController, :design
    end

    scope "/about" do
      get "/", PageController, :about
    end
  end

  scope "/werewolves-versus", ArgyleWerewolfWeb do
    get "/*path", WerewolvesVersusController, :bounce
  end

  # Other scopes may use custom stacks.
  # scope "/api", ArgyleWerewolfWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:argyle_werewolf, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: ArgyleWerewolfWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
