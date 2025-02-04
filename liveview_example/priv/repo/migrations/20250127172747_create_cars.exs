defmodule SportCars.Repo.Migrations.CreateCars do
  use Ecto.Migration

  def change do
    create table(:cars) do
      add :brand, :string
      add :model, :string
      add :sold, :boolean, default: false

      timestamps(type: :utc_datetime)
    end
  end
end
