defmodule GenserverExample.Application do
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
      {Cluster.Supervisor, [@topologies, [name: GenserverExample.ClusterSupervisor]]},
      # {Phoenix.PubSub, adapter: Phoenix.PubSub.Redis, node_name: node(), name: SportCars.PubSub},
      {Phoenix.PubSub, name: SportCars.PubSub},
      GenserverExample.CarsCounterStore
    ]

    opts = [strategy: :one_for_one, name: GenserverExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
