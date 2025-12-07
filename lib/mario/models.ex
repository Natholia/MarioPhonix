defmodule Mario.Models do
  use Ecto.Schema
  import Ecto.Changeset

  # ================================
  # User Schema
  # ================================
  defmodule User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :password_hash, :string
    field :usertype, :string   # "admin", "master", "user"

    timestamps()
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password_hash, :usertype])
    |> validate_required([:username, :password_hash, :usertype])
    |> unique_constraint(:username)
  end
end


  # ================================
  # MasterGroup Schema
  # ================================
  defmodule MasterGroup do
    use Ecto.Schema
    import Ecto.Changeset

    schema "master_groups" do
      field :master_group_name, :string
      field :login_id, :string
      field :password, :string

      has_many :groups, Mario.Models.Group

      timestamps()
    end

    def changeset(master_group, attrs) do
      master_group
      |> cast(attrs, [:master_group_name, :login_id, :password])
      |> validate_required([:master_group_name])
    end
  end

  # ================================
  # Group Schema
  # ================================
  defmodule Group do
    use Ecto.Schema
    import Ecto.Changeset

    schema "groups" do
      field :group_name, :string
      field :commission, :decimal
      field :hissa, :decimal
      field :group_type, :string
      field :ld_with_hisab, :boolean, default: false
      field :limit, :decimal
      field :is_net_bal_group, :boolean, default: false
      field :is_account, :boolean, default: false
      field :is_app_group, :boolean, default: false

      belongs_to :comm_transfer_group, Mario.Models.Group


      timestamps()
    end

    def changeset(group, attrs) do
      group
      |> cast(attrs, [
        :group_name, :commission, :hissa, :group_type,
        :ld_with_hisab, :limit, :is_net_bal_group,
        :is_account, :is_app_group, :comm_transfer_group_id
      ])
      |> validate_required([:group_name])
    end
  end
end
