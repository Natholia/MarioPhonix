defmodule Mario.Markets do
  import Ecto.Query
  alias Mario.Repo
  alias Mario.Models.Market

  def list_all do
    Repo.all(Market)
  end

  def get!(id), do: Repo.get!(Market, id)

  def create(attrs) do
    %Market{}
    |> Market.changeset(attrs)
    |> Repo.insert()
  end

  def update(market, attrs) do
    market
    |> Market.changeset(attrs)
    |> Repo.update()
  end

  def delete(market) do
    Repo.delete(market)
  end



  def assign_market_to_all_groups(market_id) do
  groups = Repo.all(Mario.Models.Group)
  now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
  entries =
    Enum.map(groups, fn group ->
      %{
        group_id: group.id,
        market_id: market_id,
        inserted_at: now,
        updated_at: now
      }
    end)
  Repo.insert_all("group_markets", entries)
end



end
