defmodule ShikcheWeb.LoginController do
  use ShikcheWeb, :controller
  require Logger

  alias Shikche.Models.User
  alias Shikche.Token

  @keys [:email, :password]
  def login(conn, params) do
    with {:decode_params, param_map} <- {:decode_params, keys_to_atom(params)},
         {:user_auth?, true} <- {:user_auth?, User.authenticated?(param_map)},
         {:token, {:ok, token, _}} <- {:token, Token.generate(param_map)} do
      conn |> put_status(200) |> json(%{token: token})
    else
      {:decode_params, _} -> conn |> put_status(403) |> json(%{reason: "bad credentials"})
      {:user_auth?, _} -> conn |> put_status(403) |> json(%{reason: "bad credentials"})
      {:token, _} -> conn |> put_status(403) |> json(%{reason: "bad credentials"})
    end
  end

  defp keys_to_atom(param_map = %{}) do
    Enum.reduce(@keys, %{}, fn key, m ->
      val = Map.get(param_map, Atom.to_string(key))
      Map.put(m, key, val)
    end)
  end
end
