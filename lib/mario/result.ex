defmodule Mario.Results do
  import Ecto.Query
  alias Mario.Repo
  alias Mario.Models.{Result, Market}

  # List results for a date, auto-create if missing
  def list_by_date(date) do
    results =
      Result
      |> where([r], r.result_date == ^date)
      |> preload(:market)
      |> Repo.all()

    if results == [] do
      create_blank_results(date)
      list_by_date(date)
    else
      results
    end
  end

  # Create default rows for each market
  def create_blank_results(date) do
    markets = Repo.all(Market)

    rows =
      Enum.map(markets, fn m ->
        %{
          market_id: m.id,
          result_date: date,
          open: nil,
          close: nil,
          inserted_at: NaiveDateTime.utc_now(),
          updated_at: NaiveDateTime.utc_now()
        }
      end)

    Repo.insert_all("results", rows)
  end

  # Update one row
  def update_row(id, attrs) do
    result = Repo.get!(Result, id)

    result
    |> Result.changeset(attrs)
    |> Repo.update()
  end

  # Delete only OPEN
  def clear_open(id) do
    update_row(id, %{open: nil})
  end

  # Delete only CLOSE
  def clear_close(id) do
    update_row(id, %{close: nil})
  end
end
