defmodule MarioWeb.RedirectController do
  use MarioWeb, :controller

  def index(conn, _params) do
    redirect(conn, to: "/admin/dashboard")
  end
end
