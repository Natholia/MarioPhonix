defmodule MarioWeb.AdminUserController do
  use MarioWeb, :controller



  plug :put_layout, html: {MarioWeb.Layouts, :admin}
  def index(conn, _params) do
    render(conn, :index, page_title: "Users")
  end
end
