defmodule ShikcheWeb.TranslationControllerTest do
  @moduledoc false

  use ShikcheWeb.ConnCase

  test "Should return 404 for non-existent translation", %{conn: conn} do
    conn = get(conn, "/api/v1/translations/no-name")
    assert 404 == Map.get(conn, :status)
    assert "{\"reason\":\"Translation not found\"}" == Map.get(conn, :resp_body)
  end

  test "Should add a translation", %{conn: conn} do
    conn =
      post(conn, "/api/v1/translations", %{
        word: "word",
        phonetic_translation: "word",
        translation: "word",
        langugage_id: 1,
        tags: ["noun"]
      })

    assert 200 == Map.get(conn, :status)
    assert "{\"message\":\"Translation added\"}" == Map.get(conn, :resp_body)
  end

  test "Should fail on adding the same translation again", %{conn: conn} do
    word = %{
      word: "word",
      phonetic_translation: "word",
      translation: "word",
      langugage_id: 1,
      tags: ["noun"]
    }

    conn = post(conn, "/api/v1/translations", word)

    assert 200 == Map.get(conn, :status)
    assert "{\"message\":\"Translation added\"}" == Map.get(conn, :resp_body)

    conn = post(conn, "/api/v1/translations", word)

    assert 400 == Map.get(conn, :status)
    assert "{\"reason\":\"Bad request\"}" == Map.get(conn, :resp_body)
  end
end
