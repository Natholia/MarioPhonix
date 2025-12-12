defmodule MarioWeb.ResultController do
  use MarioWeb, :controller
  alias Mario.Results

  def index(conn, params) do
    date =
      case params["date"] do
        nil -> Date.utc_today()
        d -> Date.from_iso8601!(d)
      end

    rows = Results.list_by_date(date)

    render(conn, :index, rows: rows, date: date)
  end
def update_open(conn, %{"id" => market_id, "open" => open}) do
  market_id = String.to_integer(market_id)

  {:ok, result} = Mario.Results.save_open(market_id, open)

  redirect(conn,
    to: "/results?date=#{Date.to_iso8601(result.result_date)}",
    flash: [info: "Open saved"]
  )
end


  def update_close(conn, %{"id" => market_id, "close" => close}) do
    {:ok, result} = Results.save_close(market_id, close)

    redirect(conn,
      to: "/results?date=#{Date.to_iso8601(result.result_date)}"
    )
  end

 # DELETE OPEN
  def delete_open(conn, %{"id" => market_id}) do
    market_id = String.to_integer(market_id)

    case Results.delete_open(market_id) do
      {:ok, _result} ->
        redirect(conn,
          to: "/results?date=#{Date.utc_today()}",
          flash: [info: "Open deleted"]
        )

      {:error, :not_found} ->
        redirect(conn,
          to: "/results?date=#{Date.utc_today()}",
          flash: [error: "No result found for today"]
        )
    end
  end

  def delete_close(conn, %{"id" => market_id}) do
    {:ok, _} = Results.delete_close(market_id)

    redirect(conn, to: "/results?date=#{Date.utc_today()}")
  end
end
