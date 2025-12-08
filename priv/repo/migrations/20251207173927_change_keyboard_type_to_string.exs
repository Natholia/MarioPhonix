defmodule Mario.Repo.Migrations.ChangeKeyboardTypeToString do
  use Ecto.Migration

  def change do
    alter table(:customers) do
      modify :mobile_customer_bid_keyboard_type, :string
    end
  end
end
