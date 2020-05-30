defmodule ShikcheWeb.TranslationController do
  @moduledoc false

  use ShikcheWeb, :controller
  require Logger

  alias Shikche.Models.Translation

  @header_authorization_key "authorization"

  def list(conn, _params) do
    json(conn, Translation.list())
  end

  def get(conn, %{"word" => word}) do
    case Translation.fuzzy_get(word) do
      [] ->
        conn |> put_status(404) |> json(%{reason: "Translation not found"})

      translations ->
        json(
          conn,
          Enum.map(translations, fn translation ->
            Map.take(translation, [:id, :word, :translation, :metadata])
          end)
        )
    end
  end

  def insert(conn, params) do
    if authorized?(conn) do
      case Translation.insert(params) do
        {:ok, translation} ->
          Logger.info("Added translation for #{translation.word}")
          json(conn, %{message: "Translation added"})

        {:error, %Ecto.Changeset{} = changeset} ->
          Logger.error(
            "Failed to add translation with changeset failure #{inspect(changeset.errors)}}"
          )

          conn |> put_status(400) |> json(%{reason: "Bad request"})

        otherwise ->
          Logger.error("Failed to add translation with error #{inspect(otherwise)}")
          conn |> put_status(500) |> json(%{reason: "Internal Server Error"})
      end
    else
      conn |> put_status(403) |> json(%{reason: "Authorization failed"})
    end
  end

  defp authorized?(conn) do
    Application.get_env(:shikche, ShikcheWeb.Endpoint, "fallback") |> Keyword.get(:auth_key) ==
      get_req_header(conn, @header_authorization_key) |> List.first()
  end
end
