defmodule MarioWeb.MarketController do
  use MarioWeb, :controller

  import Phoenix.Component

  alias Mario.Markets
  alias Mario.Models.Market
   alias Mario.Groups

   plug :put_layout, html: {MarioWeb.Layouts, :admin}

  @spec index(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def index(conn, _params) do
    markets = Markets.list_all()
    render(conn, :index, markets: markets, page_title: "Markets")
  end



def edit(conn, %{"id" => id}) do
  {market, title} =
    if id == "0" do
      {%Market{id: 0}, "New Markets"}
    else
      {Markets.get!(id), "Modify Markets"}
    end

  changeset = Market.changeset(market, %{})

  render(conn, :new,
    market: market,
    form: to_form(changeset),
    page_title: title
  )
end

def update(conn, %{"id" => id, "market" => params}) do
  {action, market} =
    if id == "0" do
      {:create, %Market{id: 0}}
    else
      {:update, Markets.get!(id)}
    end

  case action do
    :create ->
      case Markets.create(params) do
        {:ok,market} ->
           # Insert group_markets rows for ALL markets
    Mario.Markets.assign_market_to_all_groups(market.id)
          redirect(conn, to: ~p"/markets",
            flash: [info: "Market Created"])

        {:error, changeset} ->
          render(conn, :new,
            form: to_form(changeset),
            market: market,
            page_title: "New Markets"
          )
      end

    :update ->
      case Markets.update(market, params) do
        {:ok, _} ->
          redirect(conn, to: ~p"/markets",
            flash: [info: "Updated"])

        {:error, changeset} ->
          render(conn, :new,
            form: to_form(changeset),
            market: market,
            page_title: "Modify Markets"
          )
      end
  end
end


  def delete(conn, %{"id" => id}) do
    market = Markets.get!(id)
    {:ok, _} = Markets.delete(market)

    conn
    |> put_flash(:info, "Deleted")
    |> redirect(to: ~p"/markets")
  end




end
