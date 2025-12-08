defmodule MarioWeb.GroupMarketController do
  use MarioWeb, :controller

  import Phoenix.Component

    alias Mario.GroupMarket
  alias Mario.Groups
  alias Mario.Models.Group

    plug :put_layout, html: {MarioWeb.Layouts, :admin}

@spec edit(Plug.Conn.t(), map()) :: Plug.Conn.t()
def edit(conn, %{"id" => id}) do
  {customer, title} =

      {Customers.get!(id), "Modify Customers"}
  group=Groups.get!(customer.group_id)
  changeset = Customer.changeset(customer, %{})

  render(conn, :new,
  group_name: group.group_name,
    customer: customer,
    form: to_form(changeset),
    page_title: title
  )
end

# def update(conn, %{"id" => id, "customer" => params}) do
#   #  require IEx; IEx.pry()
#   {action, customer} =
#     if id == "0" do
#       {:create, %Customer{id: 0}}
#     else
#       {:update, Customers.get!(id)}
#     end

#   case action do
#     :create ->
#       case Customers.create(params) do
#         {:ok, _} ->
#           redirect(conn,to: ~p"/customer/#{params["group_id"]}",
#             flash: [info: "Customer Created"])

#         {:error, changeset} ->
#           render(conn, :new,
#             form: to_form(changeset),
#             customer: customer,
#             page_title: "New Customers"
#           )
#       end

#     :update ->
#       case Customers.update(customer, params) do
#         {:ok, _} ->
#           redirect(conn,to: ~p"/customer/#{params["group_id"]}",
#             flash: [info: "Updated"])

#         {:error, changeset} ->
#           render(conn, :new,
#             form: to_form(changeset),
#             customer: customer,
#             page_title: "Modify Customers"
#           )
#       end
#   end
# end






@spec getGroupMarket(Plug.Conn.t(), map()) :: Plug.Conn.t()
def getGroupMarket(conn, %{"id" => group_id}) do
  # Ensure group_id is an integer
  group_id = String.to_integer(group_id)
 markets = GroupMarket.list_markets_by_group(group_id)

group=Groups.get!(group_id)

 render(conn, :group_markets,
    markets: markets,
    group_id: group_id,
    page_title: "Markets of Group #{group.group_name}"
  )
end



end
