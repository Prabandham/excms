defmodule ExCmsWeb.SitesController do
  use ExCmsWeb, :controller
  alias ExCms.Sites

  def index(conn, _params) do
    sites = Sites.list_sites()
    render(conn, "index.html", sites: sites)
  end

  def new(conn, _params) do
    changeset = ExCms.Sites.change_site(%ExCms.Sites.Site{})
    pages = [%ExCms.Sites.Page{}]
    render(conn, "new.html", changeset: changeset, pages: pages)
  end

  def create(conn, %{"site" => sites_params}) do
    case ExCms.Sites.create_site(sites_params) do
      {:ok, site} ->
        conn
        |> put_flash(:info, "Site created successfully")
        |> redirect(to: sites_path(conn, :index))

      {:error, changeset} ->
        pages = [%ExCms.Sites.Page{}]
        conn
        |> put_flash(:error, "Please correct the errors below")
        |> render("new.html", changeset: changeset, pages: pages)
    end
  end

  def show(conn, %{"id" => id}) do
    site = Sites.get_site!(id)
    render(conn, "show.html", site: site)
  end

  def edit(conn, %{"id" => id}) do
    site = ExCms.Sites.get_site!(id)
    pages = site.pages |> Enum.map(fn(page) -> page.name end)
  end
end
