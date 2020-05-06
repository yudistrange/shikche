defmodule ShikcheWeb.TranslationController do
  @moduledoc false

  use ShikcheWeb, :controller
  require Logger

  alias Shikche.Models.Translations

  def list(conn, _params) do
    json(conn, Translations.list())
  end

  def get(conn, %{"word" => word}) do
    case Translations.get(word) do
      %Translations{} = translation ->
        json(conn, Map.take(translation, [:id, :word, :translation, :tags]))

      _ ->
        conn |> put_status(404) |> json(%{reason: "Translation not found"})
    end
  end

  def insert(conn, params) do
    case Translations.insert(params) do
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
  end
end
