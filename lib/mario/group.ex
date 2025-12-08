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

  def update(group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  def delete(group) do
    Repo.delete(group)
  end
end
