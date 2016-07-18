use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :analysis_service, AnalysisService.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :analysis_service, AnalysisService.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "analysis_service_test",
  hostname: "db",
  pool: Ecto.Adapters.SQL.Sandbox
