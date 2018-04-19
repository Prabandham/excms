defmodule ExCmsWeb.SitesController do
  use ExCmsWeb, :controller
  alias ExCms.Sites

  def index(conn, _params) do
    sites = Sites.list_sites()
    render(conn, "index.html", sites: sites)
  end

  def show(conn, %{"id" => id}) do
    site = Sites.get_site!(id)
    render(conn, "show.html", site: site)
  end

  def new(conn, _params) do
    changeset = ExCms.Sites.change_site(%ExCms.Sites.Site{})
    render(conn, "new.html", changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    site = ExCms.Sites.get_site!(id)
    pages = site.pages |> Enum.map(fn(page) -> page.name end)
  end
end
