defmodule Shikche.Models.Languages do
  @moduledoc """
  This module defines the schema for the Languages model and the API functions around it
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Shikche.Repo
  alias Shikche.Models.Languages

  schema "languages" do
    field :name, :string, null: false
    timestamps(type: :utc_datetime)
  end

  defp changeset(%Languages{} = language, attributes \\ %{}) do
    language
    |> cast(lowecase_name(attributes), [:name])
    |> validate_required([:name])
    |> unique_constraint(:name)
  end

  def list(),
    do: Repo.all(Languages)

  def get(name),
    do: Repo.get_by(Languages, name: name)

  def insert(%{} = language_params),
    do: changeset(%Languages{}, language_params) |> Repo.insert()

  def delete(nil), do: nil
  def delete(%Languages{} = language), do: Repo.delete(language)
  def delete(name), do: name |> get() |> delete()

  defp lowecase_name(%{} = attributes),
    do: attributes |> Map.update(:name, nil, &String.downcase(&1))
end
