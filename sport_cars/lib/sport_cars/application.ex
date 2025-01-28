defmodule SportCars.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      SportCarsWeb.Telemetry,
      SportCars.Repo,
      {DNSCluster, query: Application.get_env(:sport_cars, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: SportCars.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: SportCars.Finch},
      # Start a worker by calling: SportCars.Worker.start_link(arg)
      # {SportCars.Worker, arg},
      # Start to serve requests, typically the last entry
      SportCarsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SportCars.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SportCarsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
