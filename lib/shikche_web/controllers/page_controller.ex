defmodule ShikcheWeb.PageController do
  use ShikcheWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def not_found(conn, _params),
    do: conn |> put_status(404) |> json(%{reason: "Not found"})
end
