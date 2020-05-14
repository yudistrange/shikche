defmodule Shikche.Repo.Migrations.AddUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :text, null: false
      add :email, :text, null: false
      add :password, :text, null: false
      add :role, :string, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:email])
  end
end
