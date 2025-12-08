defmodule Mario.Repo.Migrations.AddMarketAliasName do
 use Ecto.Migration

  def change do
    alter table(:markets) do
      add :aliasname, :string
    end
  end
end
