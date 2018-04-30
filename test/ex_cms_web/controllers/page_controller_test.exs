defmodule ExCmsWeb.PageControllerTest do
  use ExCmsWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "No Site found"
  end
end
