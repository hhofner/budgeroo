defmodule Budgeroo.Repo do
  use Ecto.Repo,
    otp_app: :budgeroo,
    adapter: Ecto.Adapters.Postgres
end
