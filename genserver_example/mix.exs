defmodule GenserverExample.MixProject do
  use Mix.Project

  def project do
    [
      app: :showcasing_pub_sub,
      version: "0.1.0",
      elixir: "~> 1.17.2-otp-26",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {GenserverExample.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:libcluster, "~> 3.5"},
      {:phoenix_pubsub, "~> 2.1"},
      {:phoenix_pubsub_redis, "~> 3.0"}
    ]
  end
end
