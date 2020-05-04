defmodule Shikche.Models.Translations do
  @moduledoc """
  This module defines the schema for the Translations model and the API functions around it
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Shikche.Repo
  alias Shikche.Models.Translations

  schema "translations" do
    field :word, :string, primary_key: true
    field :phonetic_translation, :string, null: false
    field :translation, :string
    field :tags, {:array, :string}

    timestamps(type: :utc_datetime)
  end

  defp changeset(%Translations{} = translation, attributes) do
    translation
    |> cast(attributes, [:word, :phonetic_translation, :translation, :tags])
    |> validate_required([:word, :phonetic_translation, :translation, :tags])
    |> unique_constraint(:word)
  end

  def list(),
    do: Repo.all(Translations)

  def get(word),
    do: Repo.get_by(Translations, word: word)

  def insert(%{} = translation_params),
    do: changeset(%Translations{}, translation_params) |> Repo.insert()

  def delete(nil), do: nil
  def delete(%Translations{} = translation), do: Repo.delete(translation)
  def delete(word), do: word |> get() |> delete()
end
