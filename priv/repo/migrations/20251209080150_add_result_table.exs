defmodule Mario.Repo.Migrations.AddResultTable do
  use Ecto.Migration

  def change do
  create table(:results) do
    add :market_id, references(:markets, on_delete: :delete_all)
    add :result_date, :date
    add :open, :string
    add :close, :string

    timestamps()
  end

  create index(:results, [:market_id])
end
end
