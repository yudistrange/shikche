defmodule ShikcheWeb.PageController do
  use ShikcheWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
