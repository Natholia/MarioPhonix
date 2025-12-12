defmodule Mario.Repo.Migrations.MakeGroupColumnsNullable do
  use Ecto.Migration

  def change do
    alter table(:bids) do
      modify :group_id, :integer, null: true
      modify :group_market_id, :integer, null: true
    end
  end
end
