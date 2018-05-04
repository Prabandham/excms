defmodule ExCmsWeb.SessionsController do
  use ExCmsWeb, :controller

  def new(conn, _params) do
    render(conn, "new.html")
  end

  def validate(conn, %{"validate" => login_params}) do
    case ExCms.Accounts.Auth.is_valid?(login_params["email"], login_params["password"]) do
      {true, user_id} ->
        conn
        |> put_session(:user_id, user_id)
        |> redirect(to: dashboard_path(conn, :index))
      {false, nil} ->
        conn
        |> put_flash(:error, "Invalid Credentials")
        |> redirect(to: sessions_path(conn, :new))
    end
  end
end