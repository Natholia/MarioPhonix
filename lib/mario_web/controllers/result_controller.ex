defmodule MarioWeb.ResultController do
  use MarioWeb, :controller
  alias Mario.Results

  def index(conn, params) do

    require IEx
     IEx.pry()  
    date =
      case params["date"] do
        nil -> Date.utc_today()
        d -> Date.from_iso8601!(d)
      end

    rows = Results.list_by_date(date)

    render(conn, :index, rows: rows, date: date)
  end
def update_open(conn, %{"id" => market_id, "open" => open, "date" => date}) do
  market_id = String.to_integer(market_id)
  date = Date.from_iso8601!(date)

  {:ok, result} = Mario.Results.save_open(market_id, open, date)

  redirect(conn,
    to: "/results?date=#{Date.to_iso8601(result.result_date)}",
    flash: [info: "Open saved"]
  )
end

def update_close(conn, %{"id" => market_id, "close" => close, "date" => date}) do
  market_id = String.to_integer(market_id)
  date = Date.from_iso8601!(date)

  {:ok, result} = Mario.Results.save_close(market_id, close, date)

  redirect(conn,
    to: "/results?date=#{Date.to_iso8601(result.result_date)}",
    flash: [info: "Close saved"]
  )
end

def delete_open(conn, %{"id" => market_id, "date" => date}) do
  market_id = String.to_integer(market_id)
  date = Date.from_iso8601!(date)

  case Results.delete_open(market_id, date) do
    {:ok, _} -> redirect(conn, to: "/results?date=#{date}", flash: [info: "Open deleted"])
    {:error, :not_found} -> redirect(conn, to: "/results?date=#{date}", flash: [error: "No result found"])
  end
end

def delete_close(conn, %{"id" => market_id, "date" => date}) do
  market_id = String.to_integer(market_id)
  date = Date.from_iso8601!(date)

  case Results.delete_close(market_id, date) do
    {:ok, _} -> redirect(conn, to: "/results?date=#{date}", flash: [info: "Close deleted"])
    {:error, :not_found} -> redirect(conn, to: "/results?date=#{date}", flash: [error: "No result found"])
  end
end




end
