defmodule MarioWeb.AdminAuthController do
  use MarioWeb, :controller


  alias Mario.Users
  alias Mario.Models.User


  def login_page(conn, _params) do
    render(conn, :login)
  end

  # def login(conn, %{"username" => username, "password" => password}) do
  #   if username == "admin" && password == "1234" do
  #     conn
  #     |> put_session(:admin_id, 1)
  #     |> configure_session(renew: true)
  #     |> redirect(to: "/admin/dashboard")
  #   else
  #     conn
  #     |> put_flash(:error, "Invalid username or password")
  #     |> render(:login)
  #   end
  # end

  #  def login(conn, %{"username" => username, "password" => password}) do
  #   case Users.get_user_by_username(username) do
  #     nil ->
  #       conn
  #       |> put_flash(:error, "Invalid username or password")
  #       |> render(:login)

  #     user ->
  #       if Users.verify_password(password, user.password_hash) do
  #         conn
  #         |> put_session(:admin_id, user.id)
  #         |> put_session(:usertype, user.usertype)
  #         |> configure_session(renew: true)
  #         |> redirect(to: "/admin/dashboard")
  #       else
  #         conn
  #         |> put_flash(:error, "Invalid username or password")
  #         |> render(:login)
  #       end
  #   end
  # end
def login(conn, %{"username" => username, "password" => password}) do
  case Users.get_user_by_username(username) do
    nil ->
      conn
      |> put_flash(:error, "Invalid username or password")
      |> render(:login)

    user ->
      if password == user.password_hash do
        conn
        |> put_session(:admin_id, user.id)
        |> put_session(:usertype, user.usertype)
        |> configure_session(renew: true)
        |> redirect(to: "/dashboard")
      else
        conn
        |> put_flash(:error, "Invalid username or password")
        |> render(:login)
      end
  end
end


def logout(conn, _params) do
  conn
  |> configure_session(drop: true)   # clear session safely
  |> put_flash(:info, "Logged out successfully")
  |> redirect(to: "/login")
end



end
