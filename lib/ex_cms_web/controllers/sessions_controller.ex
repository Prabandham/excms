defmodule ExCmsWeb.SessionsController do
  use ExCmsWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end
end