defmodule ExCmsWeb.Plugs.AuthenticateUser do
  import Plug.Conn
  import Phoenix.Controller

  alias ExCmsWeb.Router.Helpers

  def init(_params) do
  end

  def call(conn, _params) do
    case conn.assigns[:user_id] do
      nil ->
        conn
        |> put_flash(:error, "You need to sign in first !!")
        |> redirect(to: Helpers.sessions_path(conn, :new))
        |> halt()
      key ->
        conn #TODO validate if this is a proper session and then continue
    end
  end
end