defmodule Mario.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :customer_name, :string, null: false
      add :mobile, :string, null: false
      add :email, :string

      add :group_id, references(:groups, on_delete: :nothing)

      add :is_block, :boolean, default: false
      add :is_default, :boolean, default: false

      # enum in Elixir → integer field
      add :mobile_customer_bid_keyboard_type, :integer, default: 1

      timestamps()
    end

    create index(:customers, [:group_id])
  end
end
