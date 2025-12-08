defmodule Mario.GroupMarket do
  import Ecto.Query
  alias Mario.Repo
  alias Mario.Models.GroupMarket

  def list_all do
    Repo.all(GroupMarket)
  end

  def get!(id), do: Repo.get!(GroupMarket, id)

  def create(attrs) do
    %GroupMarket{}
    |> GroupMarket.changeset(attrs)
    |> Repo.insert()
  end

  def update(groupmarket, attrs) do
    groupmarket
    |> GroupMarket.changeset(attrs)
    |> Repo.update()
  end

  def delete(groupmarket) do
    Repo.delete(groupmarket)
  end





def list_markets_by_group(group_id) do
  import Ecto.Query
  alias Mario.Repo
  alias Mario.Models.{GroupMarket, Market}

  query =
    from gm in GroupMarket,
      join: m in Market, on: m.id == gm.market_id,
      where: gm.group_id == ^group_id,
      select: {gm, m},
      order_by: [asc: m.market_name]

  Repo.all(query)
end








end
