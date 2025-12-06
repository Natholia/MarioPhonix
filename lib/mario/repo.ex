defmodule Mario.Repo do
  use Ecto.Repo,
    otp_app: :mario,
    adapter: Ecto.Adapters.Postgres
end
