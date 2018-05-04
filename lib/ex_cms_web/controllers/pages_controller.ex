defmodule ExCmsWeb.PagesController do
  use ExCmsWeb, :controller

  def index(conn, _params) do
    host = conn.host
    pages = ExCms.Sites.list_pages(host)
    render(conn, "index.html", pages: pages)
  end

  def new(conn, _params) do
    changeset = ExCms.Sites.change_page(%ExCms.Sites.Page{})
    sites = [ExCms.Sites.get_site_by_domain(conn.host)]
    layouts = ExCms.Sites.list_layouts(conn.host)
    page = %ExCms.Sites.Page{}
    render(conn, "new.html", changeset: changeset, sites: sites, layouts: layouts, page: page)
  end

  def create(conn, %{"page" => pages_params}) do
    case ExCms.Sites.create_page(pages_params) do
      {:ok, page} ->
        conn
        |> put_flash(:info, "Page created successfully")
        |> redirect(to: pages_path(conn, :index))

      {:error, changeset} ->
        sites = ExCms.Sites.list_sites()
        layouts = ExCms.Sites.list_layouts()

        conn
        |> put_flash(:error, "Please correct the errors below")
        |> render("new.html", changeset: changeset, sites: sites, layouts: layouts)
    end
  end

  def show(conn, %{"id" => id}) do
    page = ExCms.Sites.get_page!(id)
    content = ExCms.Utils.BuildPage.render(page.content, page.site_id, page.layout_id, page.title)

    conn
    |> put_layout(false)
    |> render("show.html", content: content)
  end

  def edit(conn, %{"id" => id}) do
    page = ExCms.Sites.get_page!(id)
    changeset = ExCms.Sites.change_page(page)
    sites = [ExCms.Sites.get_site_by_domain(conn.host)]
    layouts = ExCms.Sites.list_layouts(conn.host)
    render(conn, "edit.html", changeset: changeset, sites: sites, layouts: layouts, page: page)
  end

  def update(conn, %{"id" => id, "page" => pages_params}) do
    page = ExCms.Sites.get_page!(id)

    case ExCms.Sites.update_page(page, pages_params) do
      {:ok, page} ->
        page = page |> ExCms.Repo.preload(:site)

        cache_key =
          if(page.name == page.site.root_page) do
            page.site.domain_name <> "/"
          else
            page.site.domain_name <> "/" <> page.name
          end

        ConCache.delete(:page_cache, cache_key)

        conn
        |> put_flash(:info, "Page updated Successfully")
        |> redirect(to: pages_path(conn, :index))

      {:error, changeset} ->
        sites = ExCms.Sites.list_sites()
        layouts = ExCms.Sites.list_layouts()

        conn
        |> put_flash(:error, "Please check the errors below")
        |> render("edit.html", changeset: changeset, sites: sites, page: page, layouts: layouts)
    end
  end

  def delete(conn, %{"id" => id}) do
    page = ExCms.Sites.get_page!(id)

    case ExCms.Repo.delete(page) do
      {:ok, struct} ->
        conn
        |> put_flash(:info, "Page successfully deleted !")
        |> redirect(to: pages_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:alert, "Page could not be deleted !")
        |> render("index.html")
    end
  end
end
