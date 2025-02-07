# Showcasing Phoenix.PubSub

This repository demonstrates how to leverage Phoenix.PubSub for efficient message broadcasting in different scenarios.

- `genserver_example`:
Share state across distributed nodes using Phoenix.PubSub and GenServer.
Nodes automatically connect via LibCluster, enabling seamless real-time state synchronization.

- `liveview_example`:
Enable real-time communication between a LiveView page and a LiveComponent.
Child components broadcast updates to the parent via Phoenix.PubSub, ensuring state consistency.
