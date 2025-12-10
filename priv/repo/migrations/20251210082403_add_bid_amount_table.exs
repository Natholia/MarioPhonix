defmodule Mario.Repo.Migrations.AddBidAmountTable do
  use Ecto.Migration

  def change do
    create table(:bids) do
      add :transaction_no, :integer
      add :in_message, :text
      add :out_message, :text
      add :name, :string
      add :mobile_no, :string

      add :date, :utc_datetime
      add :result_date, :utc_datetime

      add :market, :string
      add :is_deleted, :boolean, default: false

      add :customer_id, :integer
      add :group_id, :integer
      add :group_market_id, :integer

      add :result_type, :integer, default: 1  # enum Open=1, Close=2

      add :out_transaction_type, :string

      add :message_receive_time, :utc_datetime
      add :message_responce_time, :utc_datetime

      add :colud_chat_id, :string
      add :channel_id, :string

      timestamps()
    end

    create index(:bids, [:customer_id])
    create index(:bids, [:group_id])
    create index(:bids, [:group_market_id])
    create index(:bids, [:result_type])
    create index(:bids, [:mobile_no])
  end
end
