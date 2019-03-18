defmodule Shikche.Repo.Migrations.AddTranslations do
  use Ecto.Migration

  def change do
    create table(:translations) do
      add :word, :string, primary_key: true
      add :phonetic_translation, :string, null: false
      add :translation, :string
      add :tags, {:array, :string}

      timestamps(type: :utc_datetime)
    end

    create index(:translations, [:word], unique: true)
  end
end
