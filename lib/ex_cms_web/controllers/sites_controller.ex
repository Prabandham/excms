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
end