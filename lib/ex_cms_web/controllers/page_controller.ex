defmodule ExCmsWeb.PageController do
  use ExCmsWeb, :controller

  plug :put_layout, false

  def index(conn, %{"page" => page}) do
    host = conn.host
    site = ExCms.Sites.get_site_by_domain(host)
    [page] = site.pages |> Enum.filter(fn(p) -> p.name == page end)
    IO.inspect(page)
    content = ExCms.Utils.BuildPage.render(page.content, page.site_id, page.layout_id, page.title)
    render(conn, "index.html", content: content)
  end
  def index(conn, _params) do
    host = conn.host
    site = ExCms.Sites.get_site_by_domain(host)
    [page] = site.pages |> Enum.filter(fn(p) -> p.name == site.root_page end)
    content = ExCms.Utils.BuildPage.render(page.content, page.site_id, page.layout_id, page.title)
    render(conn, "index.html", content: content)
  end

end
