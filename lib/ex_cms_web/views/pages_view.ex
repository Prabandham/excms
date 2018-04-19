defmodule ExCmsWeb.PagesView do
  use ExCmsWeb, :view

  def format_page_content(page) do
    if(page.site_id == nil) do
      "<p class='text-center'>Page preview will be shown here</p>"
    else
      ExCms.Utils.BuildPage.render(page.content, page.site_id, page.layout_id, page.title)
    end
  end
end
