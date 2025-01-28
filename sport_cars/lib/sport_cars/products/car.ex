defmodule SportCars.Products.Car do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cars" do
    field :brand, :string
    field :model, :string
    field :sold, :boolean, default: false

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(car, attrs) do
    car
    |> cast(attrs, [:brand, :model, :sold])
    |> validate_required([:brand, :model, :sold])
  end
end
