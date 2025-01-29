defmodule SportCars.CarsCounterStore do

  @moduledoc """
  This GenServer module is responsible for storing the amount of cars by brand.
  """

  use GenServer

  require Logger

  @pubsub SportCars.PubSub
  @topic inspect(__MODULE__)

  # Client API | Public API functions
  def start_link(opts) do
    inital_state = %{}
    opts = Keyword.put_new(opts, :name, __MODULE__)
    GenServer.start_link(__MODULE__, inital_state, opts)
  end

  def get_brand_counter(brand_name) do
    GenServer.call(__MODULE__, {:get_brand_counter, brand_name})
  end

  def increment_brand_counter(brand_name) do
    GenServer.cast(__MODULE__, {:increment_brand_counter, brand_name})
  end

  # GenServer callbacks | Private API functions
  def init(state) do
    {:ok, state, {:continue, :setup_pubsub}}
  end

  def handle_call({:get_brand_counter, brand_name}, _from, state) do
    {:reply, Map.get(state, brand_name), state}
  end

  def handle_cast({:increment_brand_counter, brand_name}, state) do
    new_state = Map.put(state, brand_name, Map.get(state, brand_name, 0) + 1)

    Logger.debug("Setting state to #{inspect(new_state)} and broadcasting to topic: #{@topic}")

    Phoenix.PubSub.broadcast!(
      @pubsub,
      @topic,
      {:sync_state, new_state}
    )

    {:noreply, new_state}
  end

  def handle_continue(:setup_pubsub, state) do
    Phoenix.PubSub.subscribe(@pubsub, @topic)
    Logger.debug("Subscribed to topic: #{@topic}")
    {:noreply, state}
  end

  def handle_info({:sync_state, new_state}, _current_state) do
    Logger.debug("Sync state called")
    {:noreply, new_state}
  end
end
