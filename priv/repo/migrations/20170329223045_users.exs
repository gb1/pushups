defmodule Pushups.Repo.Migrations.Users do
  use Ecto.Migration

  def change do

    create table(:users) do
      add :user, :string
      add :week, :integer
      add :day, :integer
      add :level, :integer
      timestamps()

    end
    create unique_index(:users, [:user])
  end
end
