defmodule Shikche.Repo do
  use Ecto.Repo,
    otp_app: :shikche,
    adapter: Ecto.Adapters.Postgres
end
