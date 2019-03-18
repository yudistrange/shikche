defmodule ShikcheWeb.LanguageController do
  @moduledoc false

  use ShikcheWeb, :controller
  alias Shikche.Models.Languages

  def list(conn, _params) do
    json(conn, Languages.list())
  end

  def get(conn, %{"name" => name}) do
    case Languages.get(name) do
      %Languages{} = language ->
        json(conn, language)

      _ ->
        conn |> put_status(404) |> json(%{reason: "Language not found"})
    end
  end
end
