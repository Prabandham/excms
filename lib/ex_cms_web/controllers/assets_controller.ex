defmodule ExCmsWeb.AssetsController do
  use ExCmsWeb, :controller

  def index(conn, params) do
    host = conn.host
    assets = ExCms.Sites.list_assets(host)
    page = assets |> ExCms.Repo.paginate(params)
    render(conn, "index.html", page: page)
  end

  def new(conn, _params) do
    changeset = ExCms.Sites.change_asset(%ExCms.Sites.Asset{})
    sites = [ExCms.Sites.get_site_by_domain(conn.host)]
    render(conn, "new.html", changeset: changeset, sites: sites)
  end

  def create(conn, %{"asset" => assets_params}) do
    path =
      if upload = assets_params["content"] do
        extension = Path.extname(upload.filename)
        "/cms_assets/#{assets_params["name"]}-#{assets_params["site_id"]}#{extension}"
      end

    assets_params = Map.put(assets_params, "content", path)

    asset =
      case ExCms.Sites.create_asset(assets_params) do
        {:ok, asset} ->
          if path do
            extension = Path.extname(upload.filename)

            File.cp(
              upload.path,
              "./cms_assets/#{assets_params["name"]}-#{assets_params["site_id"]}#{extension}"
            )
            ExCms.Utils.PageCache.expire_cache(asset.site_id)
            redirect(conn, to: assets_path(conn, :index))
          end

        {:error, changeset} ->
          sites = ExCms.Sites.list_sites()
          render(conn, "new.html", changeset: changeset, sites: sites)
      end
  end

  def edit(conn, %{"id" => id}) do
    asset = ExCms.Sites.get_asset!(id)
    changeset = ExCms.Sites.change_asset(asset)
    sites = [ExCms.Sites.get_site_by_domain(conn.host)]
    render(conn, "edit.html", changeset: changeset, sites: sites, asset: asset)
  end

  def update(conn, %{"id" => id, "asset" => assets_params}) do
    asset = ExCms.Sites.get_asset!(id)

    path =
      if upload = assets_params["content"] do
        extension = Path.extname(upload.filename)
        "/cms_assets/#{assets_params["name"]}-#{assets_params["site_id"]}#{extension}"
      end

    assets_params = Map.put(assets_params, "content", path)

    case ExCms.Sites.update_asset(asset, assets_params) do
      {:ok, asset} ->
        File.cp(
          upload.path,
          "./cms_assets/#{assets_params["name"]}-#{assets_params["site_id"]}#{extension}"
        )

        ExCms.Utils.PageCache.expire_cache(asset.site_id)

        conn
        |> put_flash(:info, "Successfuly updated asset")
        |> redirect(to: assets_path(conn, :index))

      {:error, changeset} ->
        sites = ExCms.Sites.list_sites()

        conn
        |> put_flash(:alert, "Please check errors below")
        |> render("edit.html", changeset: changeset, sites: sites, asset: asset)
    end
  end

  def delete(conn, %{"id" => id}) do
    asset = ExCms.Sites.get_asset!(id)

    case ExCms.Repo.delete(asset) do
      {:ok, struct} ->
        path = "." <> asset.content
        File.rm(path)

        ExCms.Utils.PageCache.expire_cache(asset.site_id)

        conn
        |> put_flash(:info, "Asset successfully deleted !")
        |> redirect(to: assets_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:alert, "Asset could not be deleted !")
        |> render("index.html")
    end
  end
end
