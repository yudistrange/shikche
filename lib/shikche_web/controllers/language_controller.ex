defmodule ShikcheWeb.LanguageController do
  @moduledoc false

  use ShikcheWeb, :controller
  alias Shikche.Models.Language

  def list(conn, _params) do
    json(conn, Language.list())
  end

  def get(conn, %{"name" => name}) do
    case Language.get(name) do
      %Language{} = language ->
        json(conn, Map.take(language, [:id, :name]))

      _ ->
        conn |> put_status(:not_found) |> json(%{reason: "Language not found"})
    end
  end
end
