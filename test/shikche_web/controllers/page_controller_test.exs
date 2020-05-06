defmodule ShikcheWeb.PageControllerTest do
  use ShikcheWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert 200 == Map.get(conn, :status)
    assert html_response(conn, 200) =~ "root"
  end
end
