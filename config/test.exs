use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :shikche, ShikcheWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :shikche, Shikche.Repo,
  username: "postgres",
  password: "postgres",
  database: "shikche_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
