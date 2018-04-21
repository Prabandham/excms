defmodule ExCmsWeb.PagesChannel do
  use Phoenix.Channel

  def join("pages:preview", message, socket) do
    {:ok, socket}
  end

  def handle_in(
        "show_preview",
        %{"data" => data, "site_id" => site_id, "layout_id" => layout_id, "title" => title},
        socket
      ) do
    data = ExCms.Utils.BuildPage.render(data, site_id, layout_id, title)
    push(socket, "preview_data", %{data: data})
    {:noreply, socket}
  end
end
