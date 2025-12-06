defmodule Mario.Users do
  import Ecto.Query
 alias Mario.Repo

   alias Mario.Models.User

  require Logger

  def get_user_by_username(username) do
    Repo.get_by(User, username: username)
  end

  def verify_password(password, password_hash) do
    Bcrypt.verify_pass(password, password_hash)
  end
end



