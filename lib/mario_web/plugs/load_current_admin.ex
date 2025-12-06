defmodule MarioWeb.LoadCurrentAdmin do
  import Plug.Conn
  alias Mario.Repo
  alias Mario.Models.User

  def init(opts), do: opts

  def call(conn, _opts) do
    case get_session(conn, :admin_id) do
      nil ->
        conn

      admin_id ->
        user = Repo.get(User, admin_id)

        conn
        |> assign(:current_admin, user)
        |> assign(:current_usertype, user && user.usertype)
    end
  end
end
