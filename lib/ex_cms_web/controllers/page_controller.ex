defmodule ExCmsWeb.PageController do
  use ExCmsWeb, :controller

  plug(:put_layout, false)

  def index(conn, %{"page" => page}) do
    host = if(String.contains?(conn.host, "www")) do
      [h | t] = String.split(conn.host)
      Enum.join(t, ".")
    else
      conn.host
    end
    case ExCms.Utils.PageCache.get_site_from_cache(host) do
      {:error, %{}} -> render(conn, "no_site.html")
      {:ok, site} ->
        try do
          content = ExCms.Utils.PageCache.get_page_from_cache(host, page)
          render(conn, "index.html", content: content)
        rescue
          MatchError -> render(conn, "404.html")
        end
    end
  end

  # This will always be the root path only i.e "/"
  def index(conn, _params) do
    host = if(String.contains?(conn.host, "www")) do
      [h | t] = String.split(conn.host)
      Enum.join(t, ".")
    else
      conn.host
    end
    case ExCms.Utils.PageCache.get_site_from_cache(host) do
      {:error, %{}} -> render(conn, "no_site.html")
      {:ok, site} ->
        try do
          content = ExCms.Utils.PageCache.get_page_from_cache(host, site.root_page)
          render(conn, "index.html", content: content)
        rescue
          ArgumentError -> render(conn, "404.html")
        end
    end
  end
end
