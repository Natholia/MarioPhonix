defmodule MarioWeb.GroupMarketController do
  use MarioWeb, :controller

  import Phoenix.Component



 alias Mario.Models.GroupMarket
  alias Mario.GroupMarkets
  alias Mario.Groups



    plug :put_layout, html: {MarioWeb.Layouts, :admin}

@spec edit(Plug.Conn.t(), map()) :: Plug.Conn.t()
def edit(conn, %{"id" => id}) do
  {groupmarket, title} =
      {GroupMarkets.get_group_market_with_market!(id), "Modify Group Market"}
  changeset =GroupMarket.changeset(groupmarket, %{})
  render(conn, :new,
    groupmarket: groupmarket,
    form: to_form(changeset),
    page_title: title
  )
end



def update(conn, %{"id" => id, "group_market" => params}) do


  groupmarket  = GroupMarkets.get!(id)

      case GroupMarkets.update(groupmarket, params) do
        {:ok, _} ->
          redirect(conn,to: ~p"/groupmarket/#{params["group_id"]}",
            flash: [info: "Updated"])

        {:error, changeset} ->
          render(conn, :new,
            form: to_form(changeset),
            groupmarket: groupmarket,
            page_title: "Modify Customers"
          )
      end

end


#   def update(conn, %{"id" => id, "groupmarket" => params}) do
# require IEx
# IEx.pry()


#   groupmarket = GroupMarkets.get!(id)
#       case GroupMarkets.update(groupmarket, params) do
#         {:ok, _} ->


#           redirect(conn,to: ~p"/groupmarkets/#{params["group_id"]}",
#             flash: [info: "Updated"])

#         {:error, changeset} ->
#           render(conn, :new,
#             form: to_form(changeset),
#             customer: groupmarket,
#             page_title: "Modify Customers"
#           )
#       end
#   end




    #  redirect(conn,to: ~p"/customer/#{params["group_id"]}",




@spec getGroupMarket(Plug.Conn.t(), map()) :: Plug.Conn.t()
def getGroupMarket(conn, %{"id" => group_id}) do
  # Ensure group_id is an integer
  group_id = String.to_integer(group_id)
 markets = GroupMarkets.list_markets_by_group(group_id)

group=Groups.get!(group_id)

 render(conn, :group_markets,
    markets: markets,
    group_id: group_id,
    page_title: "Markets of Group #{group.group_name}"
  )
end



end
