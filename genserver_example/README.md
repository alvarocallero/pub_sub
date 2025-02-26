# GenserverExample
This is a simple Elixir project to showcase how we can broadcast messages through Phoenix.PubSub between GenServer nodes connected through LibCluster.

To run this app, follow these steps:

  * Run `iex --sname node1@localhost -S mix` in one terminal, and `iex --sname node2@localhost -S mix` in another one.
  * In the iex console of node1, start broadcasting messages executing `GenserverExample.CarsCounterStore.increment_brand_counter("Ferrari")` several times.
  * In the iex console of node2, check for updates in the state through `GenserverExample.CarsCounterStore.get_brand_counter("Ferrari")`
  * If you want to try the Redis adapter, uncomment it in the `application.ex` file, have a Redis server up and running, and repeat steps #1 and #2.
