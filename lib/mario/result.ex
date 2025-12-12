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

  # CREATE or UPDATE OPEN
  def save_open(market_id, open) do
    today = Date.utc_today()

    result =
      Repo.one(
        from r in Result,
          where: r.market_id == ^market_id and r.result_date == ^today
      )

    case result do
      nil ->
        Repo.insert(%Result{
          market_id: market_id,
          result_date: today,
          open: open
        })

      r ->
        r
        |> Result.changeset(%{open: open})
        |> Repo.update()
    end
  end

  # UPDATE CLOSE (must exist)
  def save_close(market_id, close) do
    today = Date.utc_today()

    result =
      Repo.get_by!(Result, market_id: market_id, result_date: today)

    result
    |> Result.changeset(%{close: close})
    |> Repo.update()
  end

  # DELETE OPEN
def delete_open(market_id) do
  today = Date.utc_today()

  case Repo.get_by(Result, market_id: market_id, result_date: today) do
    nil ->
      {:error, :not_found}

    result ->
      Repo.delete(result)
  end
end



  # DELETE CLOSE
  def delete_close(market_id) do
    today = Date.utc_today()

    case Repo.get_by(Result, market_id: market_id, result_date: today) do
      nil -> {:error, :not_found}
      r ->
        r
        |> Result.changeset(%{close: nil})
        |> Repo.update()
    end
  end
end
