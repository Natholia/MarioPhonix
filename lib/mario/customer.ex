defmodule Mario.Customers do
  import Ecto.Query
  alias Mario.Repo
  alias Mario.Models.Customer

  def list_all do
    Repo.all(Customer)
  end

  def get!(id), do: Repo.get!(Customer, id)

  def create(attrs) do
    %Customer{}
    |> Customer.changeset(attrs)
    |> Repo.insert()
  end

  def update(customer, attrs) do
    customer
    |> Customer.changeset(attrs)
    |> Repo.update()
  end

  def delete(customer) do
    Repo.delete(customer)
  end

def list_by_group(group_id) do
  import Ecto.Query
  alias Mario.Repo
  alias Mario.Models.Customer

  query =
    from c in Customer,
      where: c.group_id == ^group_id,
      order_by: [asc: c.customer_name]

  Repo.all(query)
end


end
