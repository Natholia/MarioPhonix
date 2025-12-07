defmodule Mario.Groups do
  import Ecto.Query
  alias Mario.Repo
  alias Mario.Models.Group

  def list_all do
    Repo.all(Group)
  end

  def get!(id), do: Repo.get!(Group, id)

  def create(attrs) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  def update(master_group, attrs) do
    master_group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  def delete(master_group) do
    Repo.delete(master_group)
  end
end
