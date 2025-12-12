defmodule Mario.Results do
  import Ecto.Query
  alias Mario.Repo
  alias Mario.Models.{Result, Market}

  # LIST ALL MARKETS + RESULT FOR A DATE
  def list_by_date(date) do
    from(m in Market,
      left_join: r in Result,
      on: r.market_id == m.id and r.result_date == ^date,
      order_by: m.id,
      select: %{market: m, result: r}
    )
    |> Repo.all()
  end


  def save_open(market_id, open, date) do
  result =
    Repo.one(
      from r in Result,
        where: r.market_id == ^market_id and r.result_date == ^date
    )

  case result do
    nil ->
      Repo.insert(%Result{market_id: market_id, result_date: date, open: open})

    r ->
      r
      |> Result.changeset(%{open: open})
      |> Repo.update()
  end
end

def save_close(market_id, close, date) do
  result =
    Repo.get_by!(Result, market_id: market_id, result_date: date)

  result
  |> Result.changeset(%{close: close})
  |> Repo.update()
end

def delete_open(market_id, date) do
  case Repo.get_by(Result, market_id: market_id, result_date: date) do
    nil -> {:error, :not_found}
    r -> Repo.delete(r)
  end
end

def delete_close(market_id, date) do
  case Repo.get_by(Result, market_id: market_id, result_date: date) do
    nil -> {:error, :not_found}
    r -> r |> Result.changeset(%{close: nil}) |> Repo.update()
  end
end




end
