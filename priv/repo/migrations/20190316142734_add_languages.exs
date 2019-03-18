defmodule Shikche.Repo.Migrations.AddLanguages do
  use Ecto.Migration

  def change do
    create table(:languages) do
      add :name, :string, null: false
      timestamps(type: :utc_datetime)
    end

    create index(:languages, [:name], unique: true)
  end
end
