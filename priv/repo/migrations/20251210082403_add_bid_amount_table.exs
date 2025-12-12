defmodule Mario.Repo.Migrations.AddBidAmountTable do
  use Ecto.Migration

  def change do
    create table(:bid_amounts) do
      add :bids_id, references(:bids, on_delete: :delete_all)
      add :bids_date, :utc_datetime

      add :result_id, references(:results, on_delete: :nilify_all)
      add :customer_id, references(:customers, on_delete: :nilify_all)

      add :group_market_id, references(:group_markets, on_delete: :delete_all), null: false
      add :market_id, references(:markets, on_delete: :nilify_all)

      add :group_id, references(:groups, on_delete: :delete_all), null: false

      add :result_type, :integer, null: false

      add :bid_head_type, :integer, null: false, default: 0
      add :bid_pattern_type, :integer, null: false, default: 0

      add :number, :string, null: false
      add :number_jodi, :string
      add :jodi_active, :boolean, null: false, default: false

      add :bid_amount, :decimal, precision: 18, scale: 2, null: false
      add :win_amount, :decimal, precision: 18, scale: 2, null: false
      add :settling_amount, :decimal, precision: 18, scale: 2, null: false
      add :commission_amount, :decimal, precision: 18, scale: 2, null: false
      add :hissa_amount, :decimal, precision: 18, scale: 2, null: false
      add :hissa_percent, :decimal, precision: 18, scale: 2, null: false
      add :commission_percent, :decimal, precision: 18, scale: 2, null: false
      add :final_amount, :decimal, precision: 18, scale: 2, null: false

      add :is_win, :boolean, null: false, default: false
      add :rate, :decimal, precision: 18, scale: 2, null: false
      add :bid_string, :text
      add :is_jodi, :boolean, null: false, default: false

      add :temp_rate, :decimal, precision: 18, scale: 2, null: false
      add :temp_win_amount, :decimal, precision: 18, scale: 2, null: false
      add :temp_settling_amount, :decimal, precision: 18, scale: 2, null: false
      add :temp_commission_amount, :decimal, precision: 18, scale: 2, null: false
      add :temp_hissa_amount, :decimal, precision: 18, scale: 2, null: false

      add :hissa_loss, :decimal, precision: 18, scale: 2, null: false
      add :final_loss, :decimal, precision: 18, scale: 2, null: false
      add :temp_final_amount, :decimal, precision: 18, scale: 2, null: false

      timestamps()
    end

    create index(:bid_amounts, [:bids_id])
    create index(:bid_amounts, [:result_id])
    create index(:bid_amounts, [:customer_id])
    create index(:bid_amounts, [:group_market_id])
    create index(:bid_amounts, [:market_id])
    create index(:bid_amounts, [:group_id])
  end
end
