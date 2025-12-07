defmodule MarioWeb.GroupController do
  use MarioWeb, :controller

  import Phoenix.Component

  alias Mario.Groups
  alias Mario.Models.Group

   plug :put_layout, html: {MarioWeb.Layouts, :admin}

  @spec index(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def index(conn, _params) do
    groups = Groups.list_all()
    render(conn, :index, groups: groups, page_title: "Groups")
  end

  @spec new(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def new(conn, _params) do
    changeset = Group.changeset(%Group{}, %{})
    render(conn, :new, form: to_form(changeset), page_title: "New Groups")
  end

  def create(conn, %{"group" => params}) do
    case Groups.create(params) do
      {:ok, _group} ->
        conn
        |> put_flash(:info, "Group Created")
        |> redirect(to: ~p"/Groups")

      {:error, changeset} ->
        render(conn, :new, form: to_form(changeset))
    end
  end

  def edit(conn, %{"id" => id}) do
    group = Groups.get!(id)
    changeset = Group.changeset(group, %{})
    render(conn, :edit, group: group, form: to_form(changeset), page_title: "Modify Groups")
  end

  def update(conn, %{"id" => id, "group" => params}) do
    group = Groups.get!(id)

    case Groups.update(group, params) do
      {:ok, _group} ->
        conn
        |> put_flash(:info, "Updated")
        |> redirect(to: ~p"/groups")

      {:error, changeset} ->
        render(conn, :edit, group: group, form: to_form(changeset))
    end
  end

  def delete(conn, %{"id" => id}) do
    group = Groups.get!(id)
    {:ok, _} = Groups.delete(group)

    conn
    |> put_flash(:info, "Deleted")
    |> redirect(to: ~p"/groups")
  end
end
