defmodule Shikche.Models.Language do
  @moduledoc """
  This module defines the schema for the Language model and the API functions around it
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Shikche.Repo

  alias Shikche.Models.{Language, Translation}

  schema "languages" do
    field :name, :string, null: false
    has_many :translation, Translation

    timestamps(type: :utc_datetime)
  end

  defp changeset(%Language{} = language, attributes) do
    language
    |> cast(lowecase_name(attributes), [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

  def list(),
    do: Repo.all(Language)

  def get(name),
    do: Repo.get_by(Language, name: name)

  def insert(%{} = language_params),
    do: changeset(%Language{}, language_params) |> Repo.insert()

  def delete(nil), do: nil
  def delete(%Language{} = language), do: Repo.delete(language)
  def delete(name), do: name |> get() |> delete()

  defp lowecase_name(%{} = attributes),
    do: attributes |> Map.update(:name, nil, &String.downcase(&1))
end
