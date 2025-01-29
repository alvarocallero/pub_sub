defmodule SportCars.Products do
  @moduledoc """
  The Products context.
  """

  import Ecto.Query, warn: false
  alias SportCars.Repo

  alias SportCars.Products.Car

  @topic inspect(__MODULE__)
  @pubsub SportCars.PubSub

  # Broadcast helpers
  def subscribe() do
    Phoenix.PubSub.subscribe(@pubsub, @topic)
  end

  def broadcast({:ok, car}, tag) do
    Phoenix.PubSub.broadcast(
      @pubsub,
      @topic,
      {tag, car}
    )

    {:ok, car}
  end

  def broadcast({:error, _changeset} = error, _tag), do: error

  # CRUD functions
  def list_cars do
    Repo.all(from c in Car, order_by: [desc: c.id])
  end

  def get_car!(id), do: Repo.get!(Car, id)

  def create_car(attrs \\ %{}) do
    %Car{}
    |> Car.changeset(attrs)
    |> Repo.insert()
    |> broadcast(:car_created)
  end

  def update_car(%Car{} = car, attrs) do
    car
    |> Car.changeset(attrs)
    |> Repo.update()
    |> broadcast(:car_updated)
  end

  def delete_car(%Car{} = car) do
    Repo.delete(car)
    |> broadcast(:car_deleted)
  end

  def change_car(%Car{} = car, attrs \\ %{}) do
    Car.changeset(car, attrs)
  end
end
