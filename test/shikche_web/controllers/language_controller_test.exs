defmodule ShikcheWeb.LanguageControllerTest do
  @moduledoc false

  use ShikcheWeb.ConnCase

  test "GET /api/v1/language/:name", %{conn: conn} do
    conn = get(conn, "/api/v1/languages/no-name")
    assert 404 == Map.get(conn, :status)
    assert "{\"reason\":\"Language not found\"}" == Map.get(conn, :resp_body)
  end
end
