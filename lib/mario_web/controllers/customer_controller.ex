defmodule MarioWeb.CustomerController do
  use MarioWeb, :controller

  import Phoenix.Component
  alias Mario.Customers
  alias Mario.Models.Customer
  alias Mario.Groups
  alias Mario.Models.Group

  plug :put_layout, html: {MarioWeb.Layouts, :admin}
  @spec index(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def index(conn, _params) do
    customers = Customers.list_all()
    render(conn, :index, customers: customers, page_title: "Customers")
  end

  def new(conn, %{"id" => id}) do

     group_id = String.to_integer(id)
  {customer, title} =
      {%Customer{id: 0, group_id: group_id}, "New Customers"}

group=Groups.get!(group_id)
  changeset = Customer.changeset(customer, %{})

  render(conn, :new,
  group_name: group.group_name,
    customer: customer,
    form: to_form(changeset),
    page_title: title
  )
end

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

def update(conn, %{"id" => id, "customer" => params}) do
  #  require IEx; IEx.pry()
  {action, customer} =
    if id == "0" do
      {:create, %Customer{id: 0}}
    else
      {:update, Customers.get!(id)}
    end

  case action do
    :create ->
      case Customers.create(params) do
        {:ok, _} ->
          redirect(conn,to: ~p"/customer/#{params["group_id"]}",
            flash: [info: "Customer Created"])

        {:error, changeset} ->
          render(conn, :new,
            form: to_form(changeset),
            customer: customer,
            page_title: "New Customers"
          )
      end

    :update ->
      case Customers.update(customer, params) do
        {:ok, _} ->
          redirect(conn,to: ~p"/customer/#{params["group_id"]}",
            flash: [info: "Updated"])

        {:error, changeset} ->
          render(conn, :new,
            form: to_form(changeset),
            customer: customer,
            page_title: "Modify Customers"
          )
      end
  end
end


  def delete(conn, %{"id" => id}) do
    customer = Customers.get!(id)
    group_id = customer.group_id
    {:ok, _} = Customers.delete(customer)

    conn
    |> put_flash(:info, "Deleted")
    |> redirect(to: ~p"/customer/#{group_id}")
  end



@spec getGroupCustomer(Plug.Conn.t(), map()) :: Plug.Conn.t()
def getGroupCustomer(conn, %{"id" => group_id}) do
  # Ensure group_id is an integer
  group_id = String.to_integer(group_id)
 customers = Customers.list_by_group(group_id)

group=Groups.get!(group_id)

 render(conn, :group_customers,
    customers: customers,
    group_id: group_id,
    page_title: "Customers of Group #{group.group_name}"
  )
end


end
