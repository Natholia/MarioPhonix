defmodule MarioWeb.RequireAdminAuth do
  import Plug.Conn
  import Phoenix.Controller

  def init(opts), do: opts

  def call(conn, _opts) do
    if conn.assigns[:current_admin] do
      conn
    else
      conn
      |> redirect(to: "/login")
      |> halt()
    end
  end
end
