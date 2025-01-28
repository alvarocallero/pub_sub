defmodule SportCars.Repo do
  use Ecto.Repo,
    otp_app: :sport_cars,
    adapter: Ecto.Adapters.Postgres
end
