defmodule ExCmsWeb.LayoutView do
  use ExCmsWeb, :view

  @doc """
  We do not want to show any nav-bar on the login page which is also the root page.
  This helper function will help us decide if the page is one of those pages were we do not want to render the navbar
  """
  def should_show_nav_bar?(conn) do
    excluded_paths = ["/", "/login"]
    !Enum.member?(excluded_paths, conn.request_path)
  end
end
