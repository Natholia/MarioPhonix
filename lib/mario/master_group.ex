defmodule Mario.MasterGroups do
  import Ecto.Query
  alias Mario.Repo
  alias Mario.Models.MasterGroup

  def list_all do
    Repo.all(MasterGroup)
  end

  def get!(id), do: Repo.get!(MasterGroup, id)

  def create(attrs) do
    %MasterGroup{}
    |> MasterGroup.changeset(attrs)
    |> Repo.insert()
  end

  def update(master_group, attrs) do
    master_group
    |> MasterGroup.changeset(attrs)
    |> Repo.update()
  end

  def delete(master_group) do
    Repo.delete(master_group)
  end
end
