defmodule ExCmsWeb.PageController do
  use ExCmsWeb, :controller

  plug(:put_layout, false)

  def index(conn, %{"page" => page}) do
    case ExCms.Utils.PageCache.get_site_from_cache(conn.host) do
      {:error, %{}} -> render(conn, "no_site.html")
      {:ok, site} ->
        content = ExCms.Utils.PageCache.get_page_from_cache(conn.host, page)
        render(conn, "index.html", content: content)
    end
  end

  # This will always be the root path only i.e "/"
  def index(conn, _params) do
    case ExCms.Utils.PageCache.get_site_from_cache(conn.host) do
      {:error, %{}} -> render(conn, "no_site.html")
      {:ok, site} ->
        content = ExCms.Utils.PageCache.get_page_from_cache(conn.host, site.root_page)
        render(conn, "index.html", content: content)
    end
  end
end
