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

  def create(conn, %{ "layout" => layout_params}) do
    case ExCms.Sites.create_layout(layout_params) do
      {:ok, layout} ->
        conn
        |> put_flash(:info, "Successfuly created Layout")
        |> redirect(to: layouts_path(conn, :index))
      {:error, changeset} ->
        sites = ExCms.Sites.list_sites()
        conn
        |> put_flash(:alert, "Please check the erros below.")
        |> render("new.html", changeset: changeset, sites: sites)
    end
  end

  def edit(conn, %{"id" => id}) do
    layout = ExCms.Sites.get_layout!(id)
    changeset = ExCms.Sites.change_layout(layout)
    sites = ExCms.Sites.list_sites()
    render(conn, "edit.html", changeset: changeset, sites: sites, lay: layout)
  end

  def update(conn, %{"id" => id, "layout" => layout_params}) do
    layout = ExCms.Sites.get_layout!(id)
    case ExCms.Sites.update_layout(layout, layout_params) do
      {:ok, layout} ->
        conn
        |> put_flash(:info, "Layout updated Successfully")
        |> redirect(to: layouts_path(conn, :index))
      {:error, changeset} ->
        sites = ExCms.Sites.list_sites()
        conn
        |> put_flash(:alert, "Please check the errors below")
        |> render("edit.html", changeset: changeset, sites: sites, lay: layout)
    end
  end

  def delete(conn, %{"id" => id}) do
    asset = ExCms.Sites.get_layout!(id)

    case ExCms.Repo.delete(asset) do
      {:ok, struct} ->
        conn
        |> put_flash(:info, "Layout successfully deleted !")
        |> redirect(to: layouts_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:alert, "Layout could not be deleted !")
        |> render("index.html")
    end
  end
end