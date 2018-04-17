defmodule ExCmsWeb.AssetsView do
  use ExCmsWeb, :view

  def get_type(asset) do
    list = String.split(asset.content, ".")

    case List.last(list) do
      "js" -> "Javascript"
      "css" -> "Stylesheets"
      "png" -> "Image"
      "jpg" -> "Image"
      "jpeg" -> "Image"
      "svg" -> "Image"
      _ -> "Unknown"
    end
  end
end
