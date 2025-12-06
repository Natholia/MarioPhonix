defmodule Mario.Repo.Migrations.CreateAllTables do
  use Ecto.Migration

  def change do
    # MASTER GROUP TABLE
    create table(:master_groups) do
      add :master_group_name, :string
      add :login_id, :string
      add :password, :string

      timestamps()
    end

    # GROUP TABLE
    create table(:groups) do
      add :group_name, :string
      add :commission, :decimal
      add :hissa, :decimal
      add :group_type, :string
      add :ld_with_hisab, :boolean, default: false
      add :limit, :decimal
      add :is_net_bal_group, :boolean, default: false
      add :is_account, :boolean, default: false
      add :is_app_group, :boolean, default: false

      add :comm_transfer_group_id, references(:groups)
      add :master_group_id, references(:master_groups)

      timestamps()
    end
  end
end
