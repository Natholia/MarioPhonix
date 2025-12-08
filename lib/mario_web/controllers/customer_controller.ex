defmodule MarioWeb.CustomerController do
  use MarioWeb, :controller

  import Phoenix.Component

  alias Mario.Customers
  alias Mario.Models.Customer

   plug :put_layout, html: {MarioWeb.Layouts, :admin}

  @spec index(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def index(conn, _params) do
    customers = Customers.list_all()
    render(conn, :index, customers: customers, page_title: "Customers")
  end



def edit(conn, %{"id" => id}) do
  {customer, title} =
    if id == "0" do
      {%Customer{id: 0}, "New Customers"}
    else
      {Customers.get!(id), "Modify Customers"}
    end

  changeset = Customer.changeset(customer, %{})

  render(conn, :new,
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
          redirect(conn, to: ~p"/customers",
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
          redirect(conn, to: ~p"/customers",
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
    {:ok, _} = Customers.delete(customer)

    conn
    |> put_flash(:info, "Deleted")
    |> redirect(to: ~p"/customers")
  end
end
