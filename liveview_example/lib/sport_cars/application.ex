defmodule SportCars.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SportCars.Repo,
      {Phoenix.PubSub, name: SportCars.PubSub},
      SportCarsWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: SportCars.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    SportCarsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
