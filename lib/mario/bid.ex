defmodule Mario.Bids do
  import Ecto.Query
  alias Mario.Repo
  alias Mario.Models.Bid

  def list_all do
    Repo.all(Bid)
  end

  def get!(id), do: Repo.get!(Bid, id)

  def create(attrs) do
    %Bid{}
    |> Bid.changeset(attrs)
    |> Repo.insert()
  end

  def update(bid, attrs) do
    bid
    |> Bid.changeset(attrs)
    |> Repo.update()
  end

  def delete(bid) do
    Repo.delete(bid)
  end


  


end
