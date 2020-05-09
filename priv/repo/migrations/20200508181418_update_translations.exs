defmodule Shikche.Repo.Migrations.UpdateTranslations do
  use Ecto.Migration

  def change do
    alter table(:translations) do
      add :language_id, references(:languages), null: false
      add :metadata, :map
      remove :phonetic_translation
      remove :tags
    end
  end
end
