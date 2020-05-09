defmodule Shikche.Models.Translation do
  @moduledoc """
  This module defines the schema for the Translation model and the API functions around it
  """

  use Ecto.Schema

  import Ecto.Changeset

  alias Shikche.Repo
  alias Shikche.Models.Translation

  schema "translations" do
    field :word, :string, primary_key: true
    field :translation, :string
    field :metadata, :map
    field :language_id, :integer, null: false

    timestamps(type: :utc_datetime)
  end

  defp changeset(%Translation{} = translation, attributes) do
    translation
    |> cast(attributes, [:word, :metadata, :translation, :language_id])
    |> validate_required([:word, :metadata, :translation])
    |> unique_constraint(:word)
    |> foreign_key_constraint(:language_id)
  end

  def list(),
    do: Repo.all(Translation)

  def get(word),
    do: Repo.get_by(Translation, word: word)

  def insert(%{} = translation_params),
    do: changeset(%Translation{}, translation_params) |> Repo.insert()

  def delete(nil), do: nil
  def delete(%Translation{} = translation), do: Repo.delete(translation)
  def delete(word), do: word |> get() |> delete()
end
