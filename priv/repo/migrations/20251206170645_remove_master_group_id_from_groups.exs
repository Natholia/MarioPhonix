defmodule Mario.Repo.Migrations.RemoveMasterGroupIdFromGroups do
  use Ecto.Migration

  def change do
    alter table(:groups) do
      remove :master_group_id
    end
  end
end
