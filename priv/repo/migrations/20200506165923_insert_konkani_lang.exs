defmodule Shikche.Repo.Migrations.InsertKonkaniLang do
  use Ecto.Migration

  def up do
    execute "INSERT INTO languages (name, inserted_at, updated_at) VALUES ('konkani', now(), now())"
  end

  def down do
    execute "DELETE FROM languages WHERE name = 'konkani'"
  end
end
