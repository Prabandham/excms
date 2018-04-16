defmodule ExCmsWeb.AssetsController do
  use ExCmsWeb, :controller

  def index(conn, _params) do
    assets = ExCms.Sites.list_assets()
    render(conn, "index.html", assets: assets)
  end

  def new(conn, _params) do
    changeset = ExCms.Sites.change_asset(%ExCms.Sites.Asset{})
    sites = ExCms.Sites.list_sites()
    render(conn, "new.html", changeset: changeset, sites: sites)
  end

  def create(conn, %{"asset" => assets_params}) do
    path =
      if upload = assets_params["content"] do
        extension = Path.extname(upload.filename)
        "./cms_assets/#{assets_params["name"]}-#{assets_params["site_id"]}#{extension}"
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

            redirect(conn, to: assets_path(conn, :index))
          end

        {:error, changeset} ->
          IO.inspect(changeset)
          sites = ExCms.Sites.list_sites()
          render(conn, "new.html", changeset: changeset, sites: sites)
      end
  end
end
