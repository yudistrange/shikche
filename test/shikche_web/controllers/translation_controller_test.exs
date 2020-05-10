defmodule ShikcheWeb.TranslationControllerTest do
  @moduledoc false

  use ShikcheWeb.ConnCase
  import Shikche.Factory

  test "Should return 404 for non-existent translation", %{conn: conn} do
    conn = get(conn, "/api/v1/translations/no-name")
    assert 404 == Map.get(conn, :status)
    assert "{\"reason\":\"Translation not found\"}" == Map.get(conn, :resp_body)
  end

  @tag :skip
  test "Should add a translation", %{conn: conn} do
    lang = insert(:languages)

    conn =
      post(conn, "/api/v1/translations", %{
        word: "word",
        translation: "word",
        language_id: Map.get(lang, :id),
        metadata: %{},
        something: 5,
        else: 5
      })

    assert 200 == Map.get(conn, :status)
    assert "{\"message\":\"Translation added\"}" == Map.get(conn, :resp_body)
  end

  @tag :skip
  test "Should fail on adding the same translation again", %{conn: conn} do
    lang = insert(:languages)

    word = %{
      word: "word",
      translation: "word",
      language_id: Map.get(lang, :id),
      metadata: %{type: "noun"}
    }

    conn = post(conn, "/api/v1/translations", word)

    assert 200 == Map.get(conn, :status)
    assert "{\"message\":\"Translation added\"}" == Map.get(conn, :resp_body)

    conn = post(conn, "/api/v1/translations", word)

    assert 400 == Map.get(conn, :status)
    assert "{\"reason\":\"Bad request\"}" == Map.get(conn, :resp_body)
  end
end
