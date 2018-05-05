defmodule ExCmsWeb.Plugs.AuthenticateUser do
  import Plug.Conn
  import Phoenix.Controller

  alias ExCmsWeb.Router.Helpers

  def init(_params) do
  end

  def call(conn, _params) do
    case Plug.Conn.get_session(conn, :user_id) do
      nil ->
        conn
        |> put_flash(:error, "You need to sign in first !!")
        |> redirect(to: Helpers.sessions_path(conn, :new))
        |> halt()

      key ->
        case ExCms.Accounts.Auth.is_valid?(key) do
          true ->
            conn

          false ->
            conn
            |> put_flash(:error, "Invalid Session !!")
            |> redirect(to: Helpers.sessions_path(conn, :new))
            |> halt()
        end
    end
  end
end
