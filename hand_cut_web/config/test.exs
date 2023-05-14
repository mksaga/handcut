import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :hand_cut_web, HandCutWebWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "I/l8ywkU22JDSgDBBmB5a4k+fFofqBMD8wuUdPLSuFM9l8cAw8IcdwGoafVHE+ho",
  server: false

# In test we don't send emails.
config :hand_cut_web, HandCutWeb.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
