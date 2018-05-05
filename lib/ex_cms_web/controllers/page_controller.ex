defmodule ExCmsWeb.PageController do
  use ExCmsWeb, :controller

  plug(:put_layout, false)

  def index(conn, %{"page" => page}) do
    host = conn.host
    site = ExCms.Sites.get_site_by_domain(host)

    case site do
      nil ->
        render(conn, "no_site.html")

      _ ->
        [page] =
          site.pages
          |> Enum.filter(fn p -> p.name == page end)

        content =
          ExCms.Utils.BuildPage.render(page.content, page.site_id, page.layout_id, page.title)

        cache_key = host <> page.name
        ConCache.put(:page_cache, cache_key, content)
        render(conn, "index.html", content: content)
    end
  end

  # This will always be the root path only i.e "/"
  def index(conn, _params) do
    host = conn.host
    site = ExCms.Sites.get_site_by_domain(host)

    case site do
      nil ->
        render(conn, "no_site.html")

      _ ->
        [page] =
          site.pages
          |> Enum.filter(fn p -> p.name == site.root_page end)

        content =
          ExCms.Utils.BuildPage.render(page.content, page.site_id, page.layout_id, page.title)

        cache_key = host <> conn.request_path
        ConCache.put(:page_cache, cache_key, content)
        render(conn, "index.html", content: content)
    end
  end
end
