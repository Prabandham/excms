defmodule ExCms.Utils.BuildPage do
  @moduledoc """
    This module will take a page from the db with its sites and assets and layouts and do the neccessary parsing
    like converting the content from markdown to HTML and then render it with the proper layout.
  """
  require EEx
  require Ecto.Query

  def render(page_content, site_id, layout_id, title) do
    site = ExCms.Sites.get_site!(site_id)
    layout = ExCms.Sites.get_layout!(layout_id)
    assets = site.assets |> Enum.sort_by(fn(a) -> a.updated_at end)
    EEx.eval_string(
      layout.content,
      title: title,
      content: page_content,
      include_stylesheets: include_stylesheets(assets),
      include_javascripts: include_javascripts(assets)
    )
  end

  def include_stylesheets(assets) do
    styles = assets
    |> Enum.map(fn(asset) ->
      if(String.split(asset.content, ".") |> List.last == "css") do
       "<link rel='stylesheet' href='http://localhost:4000#{asset.content}'>"
      end
    end)
    Enum.join(styles, "\n")
  end

  def include_javascripts(assets) do
    js = assets
    |> Enum.map(fn(asset) ->
      if(String.split(asset.content, ".") |> List.last == "js") do
        "<sript type='text/javascript' src='http://localhost:4000#{asset.content}'></script>"
      end
    end)
    Enum.join(js, "\n")
  end
end
