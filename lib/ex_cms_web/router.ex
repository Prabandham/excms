defmodule ExCmsWeb.Router do
  use ExCmsWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :cms do
    plug ExCmsWeb.Plugs.AuthenticateUser
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/cms", ExCmsWeb do
    pipe_through [:browser, :cms]

    get("/", DashboardController, :index)

    resources("/sites", SitesController)
    resources("/assets", AssetsController)
    resources("/layouts", LayoutsController)
    resources("/pages", PagesController)
  end

  scope "/", ExCmsWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/cms/login", SessionsController, :new)
    get("/:page", PageController, :index)
    post("/validate", SessionsController, :validate)
  end

  # Other scopes may use custom stacks.
  # scope "/api", ExCmsWeb do
  #   pipe_through :api
  # end
end
