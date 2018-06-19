defmodule ExCmsWeb.DashboardController do
  use ExCmsWeb, :controller

  def index(conn, _params) do
    host = conn.host
    message_count = ExCms.Sites.count_contact_messages(host)
    render(conn, "index.html", message_count: message_count)
  end
end
