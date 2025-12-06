defmodule MarioWeb.MasterGroupController do
  use MarioWeb, :controller

  import Phoenix.Component

  alias Mario.MasterGroups
  alias Mario.Models.MasterGroup

  @spec index(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def index(conn, _params) do
    groups = MasterGroups.list_all()
    render(conn, :index, groups: groups)
  end

  def new(conn, _params) do
    changeset = MasterGroup.changeset(%MasterGroup{}, %{})
    render(conn, :new, form: to_form(changeset))
  end

  def create(conn, %{"master_group" => params}) do
    case MasterGroups.create(params) do
      {:ok, _group} ->
        conn
        |> put_flash(:info, "Group Created")
        |> redirect(to: ~p"/master_groups")

      {:error, changeset} ->
        render(conn, :new, form: to_form(changeset))
    end
  end

  def edit(conn, %{"id" => id}) do
    group = MasterGroups.get!(id)
    changeset = MasterGroup.changeset(group, %{})
    render(conn, :edit, group: group, form: to_form(changeset))
  end

  def update(conn, %{"id" => id, "master_group" => params}) do
    group = MasterGroups.get!(id)

    case MasterGroups.update(group, params) do
      {:ok, _group} ->
        conn
        |> put_flash(:info, "Updated")
        |> redirect(to: ~p"/master_groups")

      {:error, changeset} ->
        render(conn, :edit, group: group, form: to_form(changeset))
    end
  end

  def delete(conn, %{"id" => id}) do
    group = MasterGroups.get!(id)
    {:ok, _} = MasterGroups.delete(group)

    conn
    |> put_flash(:info, "Deleted")
    |> redirect(to: ~p"/master_groups")
  end
end
