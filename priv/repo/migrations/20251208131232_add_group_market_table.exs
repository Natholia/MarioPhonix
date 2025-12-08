defmodule Mario.Repo.Migrations.AddGroupMarketTable do
  use Ecto.Migration
def change do
  create table(:group_markets) do
    add :group_id, references(:groups, on_delete: :nothing), null: false
    add :market_id, references(:markets, on_delete: :nothing), null: false

    timestamps()
  end

  create index(:group_markets, [:group_id])
  create index(:group_markets, [:market_id])
end

end
