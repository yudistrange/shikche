defmodule Shikche.Token do
  @moduledoc """
  A module for generating and authenticating tokens using the Joken library
  """

  defmodule Helper do
    use Joken.Config
    def secret(), do: Application.get_env(:shikche, Shikche.Token)[:secret]
    def signer(), do: Joken.Signer.create("HS512", secret())
  end

  alias Shikche.Token.Helper, as: TokenHelper

  def generate(%{email: email}) do
    TokenHelper.generate_and_sign(%{email: email}, TokenHelper.signer())
  end

  def validate(token) do
    TokenHelper.verify_and_validate(token, TokenHelper.signer())
  end
end
