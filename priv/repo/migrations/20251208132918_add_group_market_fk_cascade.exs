defmodule Mario.Repo.Migrations.AddGroupMarketFkCascade do
  use Ecto.Migration

def change do
  alter table(:group_markets) do
    modify :group_id,
      references(:groups, on_delete: :delete_all),
      from: references(:groups)
  end
end

end
