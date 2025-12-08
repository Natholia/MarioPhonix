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










  # ================================
  # Market Schema
  # ================================
  defmodule Market do
    use Ecto.Schema
    import Ecto.Changeset

    schema "markets" do





       field :market_name, :string
      field :live_url, :string



  field :OpenTimeFrom, :time
  field :OpenTimeTo, :time
  field :CloseTimeFrom , :time
  field :CloseTimeTo, :time
    field :OpenSingleJodiEndTime , :time
    field :CloseSingleEndTime , :time

  field :OpenSingleLowerLimit, :decimal
field :OpenJodiLowerLimit, :decimal
field :CloseSingleLowerLimit, :decimal
field :OpenPanaLowerLimit, :decimal
    field :ClosePanaLowerLimit, :decimal
    field :Single_Khula, :decimal
    field :Jodi_Khula, :decimal
    field :Jodi_Family, :decimal
    field :Jodi_Cycle, :decimal
    field :SpPana_Khula, :decimal
    field :SpPana_Family, :decimal
    field :SpPana_SP, :decimal
    field :SpPana_CP, :decimal
    field :SpPana_Common, :decimal
    field :SpPana_Motor, :decimal
    field :SpPana_Chat, :decimal
    field :SpPana_AbrCut, :decimal
    field :SpPana_Other, :decimal
    field :DpPana_Khula, :decimal
    field :DpPana_Family, :decimal
    field :DpPana_DP, :decimal
    field :DpPana_CP, :decimal
    field :DpPana_Common, :decimal
    field :DpPana_Motor, :decimal
    field :DpPana_Other, :decimal
    field :TpPana_Khula, :decimal
    field :TpPana_Family, :decimal
    field :TpPana_TP, :decimal
    field :TpPana_CP, :decimal
    field :TpPana_Other, :decimal
    field :HalfSangam_Khula, :decimal
    field :HalfSangam_Family, :decimal
    field :HalfSangam_SP, :decimal
    field :HalfSangam_DP, :decimal
    field :HalfSangam_TP, :decimal
    field :HalfSangam_CP, :decimal
    field :HalfSangam_Common, :decimal
    field :HalfSangam_Motor, :decimal
    field :HalfSangam_Chat, :decimal
    field :HalfSangam_AbrCut, :decimal
    field :HalfSangam_Other, :decimal
    field :FullSangam_Khula, :decimal
    field :FullSangam_Family, :decimal
    field :FullSangam_SP, :decimal
    field :FullSangam_DP, :decimal
    field :FullSangam_TP, :decimal
    field :FullSangam_CP, :decimal
    field :FullSangam_Common, :decimal
    field :FullSangam_Motor, :decimal
    field :FullSangam_Chat, :decimal
    field :FullSangam_AbrCut, :decimal
    field :FullSangam_Other, :decimal
    field :aliasname, :string


      timestamps()
    end

    def changeset(group, attrs) do
      group
      |> cast(attrs, [
        :market_name,
        :live_url,
        :OpenTimeFrom,
        :OpenTimeTo,
        :CloseTimeFrom ,
        :CloseTimeTo,
        :OpenSingleJodiEndTime ,
        :CloseSingleEndTime ,
        :OpenSingleLowerLimit,
        :OpenJodiLowerLimit,
        :CloseSingleLowerLimit,
        :OpenPanaLowerLimit,
     :ClosePanaLowerLimit,
     :Single_Khula,
     :Jodi_Khula,
     :Jodi_Family,
     :Jodi_Cycle,
     :SpPana_Khula,
     :SpPana_Family,
     :SpPana_SP,
     :SpPana_CP,
     :SpPana_Common,
     :SpPana_Motor,
     :SpPana_Chat,
     :SpPana_AbrCut,
     :SpPana_Other,
     :DpPana_Khula,
     :DpPana_Family,
     :DpPana_DP,
     :DpPana_CP,
     :DpPana_Common,
     :DpPana_Motor,
     :DpPana_Other,
     :TpPana_Khula,
     :TpPana_Family,
     :TpPana_TP,
     :TpPana_CP,
     :TpPana_Other,
     :HalfSangam_Khula,
     :HalfSangam_Family,
     :HalfSangam_SP,
     :HalfSangam_DP,
     :HalfSangam_TP,
     :HalfSangam_CP,
     :HalfSangam_Common,
     :HalfSangam_Motor,
     :HalfSangam_Chat,
     :HalfSangam_AbrCut,
     :HalfSangam_Other,
     :FullSangam_Khula,
     :FullSangam_Family,
     :FullSangam_SP,
     :FullSangam_DP,
     :FullSangam_TP,
     :FullSangam_CP,
     :FullSangam_Common,
     :FullSangam_Motor,
     :FullSangam_Chat,
     :FullSangam_AbrCut,
     :FullSangam_Other,
     :aliasname
      ])
      |> validate_required([:market_name])
    end
  end



  # ================================
  # Customer Schema
  # ================================

defmodule Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :customer_name, :string
    field :mobile, :string
    field :email, :string

    field :is_block, :boolean, default: false
    field :is_default, :boolean, default: false

    field :mobile_customer_bid_keyboard_type, Ecto.Enum,
      values: [:normal, :classic],
      default: :normal

    field :group_id, :id
    belongs_to :group, Mario.Models.Group,
     define_field: false

    timestamps()
  end

  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [
      :customer_name,
      :mobile,
      :email,
      :group_id,
      :is_block,
      :is_default,
      :mobile_customer_bid_keyboard_type
    ])
    |> validate_required([:customer_name, :mobile])
  end
end




  # ================================
  # GroupMarket Schema
  # ================================

defmodule GroupMarket do
  use Ecto.Schema
  import Ecto.Changeset

  schema "group_markets" do
    belongs_to :group, Mario.Models.Group
    belongs_to :market, Mario.Models.Market




  field :OpenTimeFrom, :time
  field :OpenTimeTo, :time
  field :CloseTimeFrom , :time
  field :CloseTimeTo, :time
    field :OpenSingleJodiEndTime , :time
    field :CloseSingleEndTime , :time

  field :OpenSingleLowerLimit, :decimal
field :OpenJodiLowerLimit, :decimal
field :CloseSingleLowerLimit, :decimal
field :OpenPanaLowerLimit, :decimal
    field :ClosePanaLowerLimit, :decimal
    field :Single_Khula, :decimal
    field :Jodi_Khula, :decimal
    field :Jodi_Family, :decimal
    field :Jodi_Cycle, :decimal
    field :SpPana_Khula, :decimal
    field :SpPana_Family, :decimal
    field :SpPana_SP, :decimal
    field :SpPana_CP, :decimal
    field :SpPana_Common, :decimal
    field :SpPana_Motor, :decimal
    field :SpPana_Chat, :decimal
    field :SpPana_AbrCut, :decimal
    field :SpPana_Other, :decimal
    field :DpPana_Khula, :decimal
    field :DpPana_Family, :decimal
    field :DpPana_DP, :decimal
    field :DpPana_CP, :decimal
    field :DpPana_Common, :decimal
    field :DpPana_Motor, :decimal
    field :DpPana_Other, :decimal
    field :TpPana_Khula, :decimal
    field :TpPana_Family, :decimal
    field :TpPana_TP, :decimal
    field :TpPana_CP, :decimal
    field :TpPana_Other, :decimal
    field :HalfSangam_Khula, :decimal
    field :HalfSangam_Family, :decimal
    field :HalfSangam_SP, :decimal
    field :HalfSangam_DP, :decimal
    field :HalfSangam_TP, :decimal
    field :HalfSangam_CP, :decimal
    field :HalfSangam_Common, :decimal
    field :HalfSangam_Motor, :decimal
    field :HalfSangam_Chat, :decimal
    field :HalfSangam_AbrCut, :decimal
    field :HalfSangam_Other, :decimal
    field :FullSangam_Khula, :decimal
    field :FullSangam_Family, :decimal
    field :FullSangam_SP, :decimal
    field :FullSangam_DP, :decimal
    field :FullSangam_TP, :decimal
    field :FullSangam_CP, :decimal
    field :FullSangam_Common, :decimal
    field :FullSangam_Motor, :decimal
    field :FullSangam_Chat, :decimal
    field :FullSangam_AbrCut, :decimal
    field :FullSangam_Other, :decimal


    timestamps()
  end

  @doc false
  def changeset(group_market, attrs) do
    group_market
    |> cast(attrs, [:group_id, :market_id,
     :OpenTimeFrom,
        :OpenTimeTo,
        :CloseTimeFrom ,
        :CloseTimeTo,
        :OpenSingleJodiEndTime ,
        :CloseSingleEndTime ,
        :OpenSingleLowerLimit,
        :OpenJodiLowerLimit,
        :CloseSingleLowerLimit,
        :OpenPanaLowerLimit,
     :ClosePanaLowerLimit,
     :Single_Khula,
     :Jodi_Khula,
     :Jodi_Family,
     :Jodi_Cycle,
     :SpPana_Khula,
     :SpPana_Family,
     :SpPana_SP,
     :SpPana_CP,
     :SpPana_Common,
     :SpPana_Motor,
     :SpPana_Chat,
     :SpPana_AbrCut,
     :SpPana_Other,
     :DpPana_Khula,
     :DpPana_Family,
     :DpPana_DP,
     :DpPana_CP,
     :DpPana_Common,
     :DpPana_Motor,
     :DpPana_Other,
     :TpPana_Khula,
     :TpPana_Family,
     :TpPana_TP,
     :TpPana_CP,
     :TpPana_Other,
     :HalfSangam_Khula,
     :HalfSangam_Family,
     :HalfSangam_SP,
     :HalfSangam_DP,
     :HalfSangam_TP,
     :HalfSangam_CP,
     :HalfSangam_Common,
     :HalfSangam_Motor,
     :HalfSangam_Chat,
     :HalfSangam_AbrCut,
     :HalfSangam_Other,
     :FullSangam_Khula,
     :FullSangam_Family,
     :FullSangam_SP,
     :FullSangam_DP,
     :FullSangam_TP,
     :FullSangam_CP,
     :FullSangam_Common,
     :FullSangam_Motor,
     :FullSangam_Chat,
     :FullSangam_AbrCut,
     :FullSangam_Other])
    |> validate_required([:group_id, :market_id])
    |> assoc_constraint(:group)
    |> assoc_constraint(:market)
  end
end



end
