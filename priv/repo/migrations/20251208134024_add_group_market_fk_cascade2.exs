defmodule Mario.Repo.Migrations.AddGroupMarketFkCascade2 do
  use Ecto.Migration

def change do
  alter table(:group_markets) do
    modify :market_id,
      references(:markets, on_delete: :delete_all),
      from: references(:markets)
  end
end
end
