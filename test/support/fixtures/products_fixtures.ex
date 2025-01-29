defmodule SportCars.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `SportCars.Products` context.
  """

  @doc """
  Generate a car.
  """
  def car_fixture(attrs \\ %{}) do
    {:ok, car} =
      attrs
      |> Enum.into(%{
        brand: "some brand",
        model: "some model"
      })
      |> SportCars.Products.create_car()

    car
  end
end
