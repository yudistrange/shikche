defmodule Shikche.Models.User do
  @moduledoc """
  This module describes the user model.
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Argon2

  alias Shikche.Models.User
  alias Shikche.Repo

  schema("users") do
    field :name, :string, null: false
    field :email, :string, null: false
    field :password, :string, null: false
    field :role, :string, null: false

    timestamps(type: :utc_datetime)
  end

  defp changeset(%User{} = user, params) do
    user
    |> cast(params, [:name, :email, :password, :role])
    |> validate_required([:name, :email, :password, :role])
    |> unique_constraint(:email)
  end

  def insert(%{} = user_params) do
    params = user_params |> lowercase([:name, :email]) |> hash_password()
    changeset(%User{}, params) |> Repo.insert()
  end

  def authenticated?(%{email: email, password: password} = params) do
    case Repo.get_by(User, email: email) do
      nil -> false
      %User{password: hash} -> Argon2.verify_pass(password, hash)
    end
  end

  defp lowercase(%{} = params, attributes) do
    Enum.reduce(attributes, params, fn key, mp ->
      Map.update(mp, key, nil, &String.downcase(&1))
    end)
  end

  defp hash_password(%{password: password} = params) do
    %{password_hash: hash} = Argon2.add_hash(password)
    Map.put(params, :password, hash)
  end
end
