defmodule ExCmsWeb.SitesController do
  use ExCmsWeb, :controller
  alias ExCms.Sites
  alias ExCms.Utils.PageCache

  def index(conn, _params) do
    sites = Sites.list_sites()
    render(conn, "index.html", sites: sites)
  end

  def new(conn, _params) do
    changeset = Sites.change_site(%Sites.Site{})
    pages = [%Sites.Page{}]
    render(conn, "new.html", changeset: changeset, pages: pages)
  end

  def create(conn, %{"site" => sites_params}) do
    case Sites.create_site(sites_params) do
      {:ok, site} ->
        conn
        |> put_flash(:info, "Site created successfully")
        |> redirect(to: sites_path(conn, :index))

      {:error, changeset} ->
        pages = [%Sites.Page{}]

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
    site = Sites.get_site!(id)
    changeset = Sites.change_site(site)
    pages = site.pages
    render(conn, "edit.html", pages: pages, site: site, changeset: changeset)
  end

  def update(conn, %{"id" => id, "site" => sites_params}) do
    site = Sites.get_site!(id)

    case Sites.update_site(site, sites_params) do
      {:ok, site} ->
        PageCache.expire_cache(site.id)
        conn
        |> put_flash(:info, "Site upadted successfully")
        |> redirect(to: sites_path(conn, :index))

      {:error, changeset} ->
        pages = site.pages

        conn
        |> put_flash(:error, "Please correct the errors below")
        |> render("edit.html", changeset: changeset, pages: pages, site: site)
    end
  end
end
