defmodule MarioWeb.Router do
  use MarioWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {MarioWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug MarioWeb.LoadCurrentAdmin      # ✔ REAL PLUG
  end

  pipeline :require_admin_auth do
    plug MarioWeb.RequireAdminAuth      # ✔ PROTECT ADMIN ROUTES
  end

  scope "/", MarioWeb do
    pipe_through :browser
    get "/", RedirectController, :index
  end

  scope "/", MarioWeb do
    pipe_through :browser
    get  "/login", AdminAuthController, :login_page
    post "/login", AdminAuthController, :login
    get "/logout", AdminAuthController, :logout
  end

  scope "/admin", MarioWeb do
    pipe_through [:browser, :require_admin_auth]
    get "/dashboard", AdminDashboardController, :index
    get "/users", AdminUserController, :index
  end
end
