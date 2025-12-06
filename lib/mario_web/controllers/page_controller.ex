defmodule MarioWeb.PageController do
  use MarioWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
