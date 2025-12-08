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

def edit(conn, %{"id" => id}) do
  {group, title} =
    if id == "0" do
      {%Group{id: 0}, "New Groups"}
    else
      {Groups.get!(id), "Modify Groups"}
    end

  changeset = Group.changeset(group, %{})

  render(conn, :new,
    group: group,
    form: to_form(changeset),
    page_title: title
  )
end



def update(conn, %{"id" => id, "group" => params}) do
  #  require IEx; IEx.pry()
  {action, group} =
    if id == "0" do
      {:create, %Group{id: 0}}
    else
      {:update, Groups.get!(id)}
    end

  case action do
    :create ->
      case Groups.create(params) do
        {:ok,group} ->
              # Insert group_markets rows for ALL markets
    Mario.Groups.assign_all_markets_to_group(group.id)
          redirect(conn, to: ~p"/groups",
            flash: [info: "Group Created"])

        {:error, changeset} ->
          render(conn, :new,
            form: to_form(changeset),
            group: group,
            page_title: "New Groups"
          )
      end

    :update ->
      case Groups.update(group, params) do
        {:ok, _} ->
          redirect(conn, to: ~p"/groups",
            flash: [info: "Updated"])

        {:error, changeset} ->
          render(conn, :new,
            form: to_form(changeset),
            group: group,
            page_title: "Modify Groups"
          )
      end
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
