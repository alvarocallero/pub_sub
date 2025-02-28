defmodule SportCarsWeb.CarLive do
  use SportCarsWeb, :live_view

  alias SportCars.Products
  alias SportCars.Products.Car
  alias SportCarsWeb.CarFormComponent

  def mount(_params, _session, socket) do
    if connected?(socket) do
      Products.subscribe()
    end

    cars = Products.list_cars()

    socket =
      socket
      |> stream(:cars, cars)

    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
    <h1>🔮Beam Garage 🔧</h1>
    <div id="main-container">
      <.live_component module={CarFormComponent} id={:new} />

      <div id="cars" phx-update="stream">
        <.car :for={{car_id, car} <- @streams.cars} id={car_id} car={car} />
      </div>
    </div>
    """
  end

  attr :car, Car, required: true
  attr :id, :string, required: true

  def car(assigns) do
    ~H"""
    <div class={"car #{if @car.sold, do: "out"}"} id={@id}>
      <div class="brand">
        {@car.brand}
      </div>

      <div class="model">
        {@car.model}
      </div>

      <div class="status">
        <.link
          class="delete"
          phx-click={
            JS.push("delete", value: %{id: @car.id})
            |> JS.hide(to: "##{@id}")
          }
        >
          <.icon name="hero-trash-solid" />
        </.link>

        <button phx-click={JS.push("toggle-status", value: %{id: @car.id})}>
          {if @car.sold,
            do: "Sold",
            else: "Available"}
        </button>
      </div>
    </div>
    """
  end

  def handle_event("toggle-status", %{"id" => id}, socket) do
    car = Products.get_car!(id)

    {:ok, _car} =
      Products.update_car(car, %{sold: !car.sold})

    {:noreply, socket}
  end

  def handle_event("delete", %{"id" => id}, socket) do
    car = Products.get_car!(id)
    Products.delete_car(car)
    {:noreply, socket}
  end

  def handle_info({:car_created, car}, socket) do
    {:noreply, stream_insert(socket, :cars, car, at: 0)}
  end

  def handle_info({:car_deleted, car}, socket) do
    {:noreply, stream_delete(socket, :cars, car)}
  end

  def handle_info({:car_updated, car}, socket) do
    {:noreply, stream_insert(socket, :cars, car)}
  end
end
