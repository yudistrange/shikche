defmodule Shikche.Factory do
  use ExMachina.Ecto, repo: Shikche.Repo

  alias Shikche.Models.{Language, Translation}

  def languages_factory() do
    %Language{
      name: "language_#{:rand.uniform(100)}",
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    }
  end

  def translations_factory() do
    %Translation{
      language_id: :rand.uniform(100),
      word: "word_#{:rand.uniform(100)}",
      translation: "translation_#{:rand.uniform(100)}",
      inserted_at: DateTime.utc_now(),
      updated_at: DateTime.utc_now()
    }
  end
end
