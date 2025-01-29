defmodule SportCars.Application do
  @moduledoc false

  use Application

  @topologies [
    state_replication: [
      strategy: Cluster.Strategy.Epmd,
      config: [
        hosts: [
          :node1@localhost,
          :node2@localhost,
          :node3@localhost
        ]
      ]
    ]
  ]

  @impl true
  def start(_type, _args) do
    children = [
      SportCarsWeb.Telemetry,
      SportCars.Repo,
      {Phoenix.PubSub, name: SportCars.PubSub},
      SportCars.CarsCounterStore,
      {Cluster.Supervisor, [@topologies, [name: SportCars.ClusterSupervisor]]},
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
