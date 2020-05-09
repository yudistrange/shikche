defmodule Shikche.Repo.Migrations.MakeTranslationsNonNullable do
  use Ecto.Migration

  def change do
    alter table(:translations) do
      modify :word, :text
      modify :translation, :text, null: false
    end
  end
end
