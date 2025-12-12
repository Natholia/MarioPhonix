defmodule Mario.Repo.Migrations.AddMessageIdToBids do
  use Ecto.Migration

  def change do
    alter table(:bids) do
      add :message_id, :string
    end

    create index(:bids, [:message_id])
  end
end
