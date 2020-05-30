defmodule Shikche.Repo.Migrations.AddUniqueTranslationConstraint do
  use Ecto.Migration

  def change do
    create index(
             :translations,
             [:translation, :language_id],
             unique: true,
             name: :translation_language_unique_constraint
           )
  end
end
