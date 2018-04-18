defmodule ExCmsWeb.LayoutsController do
  use ExCmsWeb, :controller

  def index(conn, _params) do
    layouts = ExCms.Sites.list_layouts()
    render(conn, "index.html", layouts: layouts)
  end

  def new(conn, _params) do
    sites = ExCms.Sites.list_sites()
    changeset = ExCms.Sites.change_layout(%ExCms.Sites.Layout{})
    render(conn, "new.html", changeset: changeset, sites: sites)
  end

  def create(conn, %{ "layout" => layouts_params}) do
    case ExCms.Sites.create_layout(layouts_params) do
      {ok, layout} ->
        conn
        |> put_flash(:info, "Successfuly created Layout")
        |> redirect(to: layouts_path(conn, :index))
      {:error, changeset} ->
        conn
        |> put_flash(:alert, "Please check the erros below.")
        |> render("new.html", changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    layout = ExCms.Sites.get_layout!(id)
    changeset = ExCms.Sites.change_layout(layout)
    sites = ExCms.Sites.list_sites()
    render(conn, "edit.html", changeset: changeset, sites: sites, lay: layout)
  end
end