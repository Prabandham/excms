defmodule ExCmsWeb.PageController do
  use ExCmsWeb, :controller

  plug(:put_layout, false)

  def index(conn, %{"page" => page}) do
    host = if(String.contains?(conn.host, "wwww")) do
      conn.host
    else
      [h | t] = String.split(".")
      Enum.join(t, ".")
    end
    case ExCms.Utils.PageCache.get_site_from_cache(host) do
      {:error, %{}} -> render(conn, "no_site.html")
      {:ok, site} ->
        content = ExCms.Utils.PageCache.get_page_from_cache(host, page)
        render(conn, "index.html", content: content)
    end
  end

  # This will always be the root path only i.e "/"
  def index(conn, _params) do
    host = if(String.contains?(conn.host, "wwww")) do
      conn.host
    else
      [h | t] = String.split(".")
      Enum.join(t, ".")
    end
    case ExCms.Utils.PageCache.get_site_from_cache(host) do
      {:error, %{}} -> render(conn, "no_site.html")
      {:ok, site} ->
        content = ExCms.Utils.PageCache.get_page_from_cache(host, site.root_page)
        render(conn, "index.html", content: content)
    end
  end
end
