defmodule MarioWeb.MasterGroupController do
  use MarioWeb, :controller

  import Phoenix.Component

   alias Mario.Markets
  alias Mario.MasterGroups
  alias Mario.Models.MasterGroup

   plug :put_layout, html: {MarioWeb.Layouts, :admin}

  @spec index(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def index(conn, _params) do
    groups = MasterGroups.list_all()
    render(conn, :index, groups: groups, page_title: "Master Groups")
  end

  @spec new(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = MasterGroup.changeset(%MasterGroup{}, %{})
    render(conn, :new, form: to_form(changeset), page_title: "New Master Groups")
  end

  def create(conn, %{"master_group" => params}) do
    case MasterGroups.create(params) do
      {:ok, _group} ->
        conn
        |> put_flash(:info, "Group Created")
        |> redirect(to: ~p"/mastergroups")

      {:error, changeset} ->
        render(conn, :new, form: to_form(changeset))
    end
  end

  def edit(conn, %{"id" => id}) do
    group = MasterGroups.get!(id)
    changeset = MasterGroup.changeset(group, %{})
    render(conn, :edit, group: group, form: to_form(changeset), page_title: "Modify Master Groups")
  end

  def update(conn, %{"id" => id, "master_group" => params}) do
    group = MasterGroups.get!(id)

    case MasterGroups.update(group, params) do
      {:ok, _group} ->
        conn
        |> put_flash(:info, "Updated")
        |> redirect(to: ~p"/mastergroups")

      {:error, changeset} ->
        render(conn, :edit, group: group, form: to_form(changeset))
    end
  end

  def delete(conn, %{"id" => id}) do
    group = MasterGroups.get!(id)
    {:ok, _} = MasterGroups.delete(group)

    conn
    |> put_flash(:info, "Deleted")
    |> redirect(to: ~p"/mastergroups")
  end






end
