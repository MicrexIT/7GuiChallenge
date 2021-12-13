defmodule GuiChallenge.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string
      add :surname, :string

      timestamps()
    end
  end
end
