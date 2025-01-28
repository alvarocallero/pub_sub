defmodule SportCarsWeb.CarFormComponent do
  use SportCarsWeb, :live_component

  alias SportCars.Products
  alias SportCars.Products.Car

  def mount(socket) do
    change_set = Products.change_car(%Car{})
    {:ok, assign(socket, :form, to_form(change_set))}
  end

  def render(assigns) do
    ~H"""
    <div>
      <.form for={@form} phx-submit="save" phx-target={@myself}>
        <.input field={@form[:brand]} placeholder="Brand" autocomplete="off" phx-debounce="2000" />
        <.input
          field={@form[:model]}
          type="tel"
          placeholder="Model"
          autocomplete="off"
          phx-debounce="blur"
        />
        <.button phx-disable-with="Saving...">
          Save car
        </.button>
      </.form>
    </div>
    """
  end

  def handle_event("save", %{"car" => car_params}, socket) do
    case Products.create_car(car_params) do
      {:ok, _car} ->
        changeset = Products.change_car(%Car{})
        {:noreply, assign(socket, form: to_form(changeset))}

      {:error, changeset} ->
        {:noreply, assign(socket, :form, to_form(changeset))}
    end
  end
end
