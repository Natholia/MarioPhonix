defmodule MarioWeb.BidController do
  use MarioWeb, :controller
  import Phoenix.LiveView.Controller  # ✅ ADD THIS

  alias MarioWeb.BidLive
  alias Mario.Bids

  plug :put_layout, html: {MarioWeb.Layouts, :admin}

  # Redirect /bids to LiveView
  def index(conn, _params) do
    # Pass current_admin from conn.assigns to LiveView
    live_render(conn, BidLive.Index, session: %{
      "current_admin" => conn.assigns[:current_admin]
    })
  end
end
