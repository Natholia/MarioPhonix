defmodule MarioWeb.ResultController do
  use MarioWeb, :controller
  alias Mario.Results
  alias Mario.Models.Result

  plug :put_layout, html: {MarioWeb.Layouts, :admin}

  def index(conn, params) do
    date =
      case params["date"] do
        nil -> Date.utc_today()
        d -> Date.from_iso8601!(d)
      end

    results = Results.list_by_date(date)

    render(conn, :index,
      page_title: "Result",
      date: date,
      results: results
    )
  end

  # SAVE ROW
  def update(conn, %{
        "id" => id,
        "open" => open,
        "close" => close
      }) do
    {:ok, _} =
      Results.update_row(id, %{open: open, close: close})

    redirect(conn,
      to: ~p"/results?date=#{Date.utc_today()}",
      flash: [info: "Saved"]
    )
  end

  # DELETE OPEN
  def delete_open(conn, %{"id" => id}) do
    Results.clear_open(id)

    redirect(conn,
      to: ~p"/results",
      flash: [info: "Open removed"]
    )
  end

  # DELETE CLOSE
  def delete_close(conn, %{"id" => id}) do
    Results.clear_close(id)

    redirect(conn,
      to: ~p"/results",
      flash: [info: "Close removed"]
    )
  end
end
