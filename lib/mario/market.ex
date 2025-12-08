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
end
