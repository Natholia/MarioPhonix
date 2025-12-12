defmodule MarioWeb.Router do
  use MarioWeb, :router

  # ----------------------------
  # BROWSER PIPELINE
  # ----------------------------
  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {MarioWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug MarioWeb.LoadCurrentAdmin      # load current admin into conn.assigns
  end

  # ----------------------------
  # ADMIN AUTH PIPELINE
  # ----------------------------
  pipeline :require_admin_auth do
    plug MarioWeb.RequireAdminAuth
  end

  # ----------------------------
  # API PIPELINE
  # ----------------------------
  pipeline :api do
    plug :accepts, ["json"]
  end

  # ----------------------------
  # PUBLIC ROUTES
  # ----------------------------
  scope "/", MarioWeb do
    pipe_through :browser
    get "/", RedirectController, :index
  end

  # ----------------------------
  # API ROUTES
  # ----------------------------
  scope "/api", MarioWeb do
    pipe_through :api
    post "/whatsapp/webhook", WhatsAppWebhookController, :webhook
  end

  # ----------------------------
  # AUTH ROUTES (LOGIN/LOGOUT)
  # ----------------------------
  scope "/", MarioWeb do
    pipe_through :browser
    get "/login", AdminAuthController, :login_page
    post "/login", AdminAuthController, :login
    get "/logout", AdminAuthController, :logout
  end

  # ----------------------------
  # ADMIN ROUTES (REQUIRES AUTH)
  # ----------------------------
  scope "/", MarioWeb do
    pipe_through [:browser, :require_admin_auth]

    get "/dashboard", AdminDashboardController, :index

    resources "/mastergroups", MasterGroupController, except: [:show]
    resources "/groups", GroupController, except: [:show]
    resources "/markets", MarketController, except: [:show]

    resources "/groupmarkets", GroupMarketController, except: [:show]
    get "/groupmarket/:id", GroupMarketController, :getGroupMarket
    get "/groupmarkets/:id/new", GroupMarketController, :new

    resources "/customers", CustomerController, except: [:show]
    get "/customer/:id", CustomerController, :getGroupCustomer
    get "/customers/:id/new", CustomerController, :new

    get "/results", ResultController, :index
    put "/results/open/:id", ResultController, :update_open
    put "/results/close/:id", ResultController, :update_close
    post "/results/delete_open/:id", ResultController, :delete_open
    post "/results/delete_close/:id", ResultController, :delete_close

    # ----------------------------
    # BIDS ROUTES
    # LiveView for index, with session to provide current_admin
    # ----------------------------
   live "/bids", BidLive.Index, :index

    resources "/bids", BidController, except: [:index, :show]
  end
end
