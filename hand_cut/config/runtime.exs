import Config

config :hand_cut, event_stores: [HandCut.EventStore]

config :nanoid,
  size: 6,
  alphabet: "0123456789abcdefghijklmnopqrstuvwxyz"

config :hand_cut, ecto_repos: [HandCut.Projections.Repo]

config :hand_cut, HandCut.EventStore,
  serializer: Commanded.Serialization.JsonSerializer,
  username: "postgres",
  password: System.fetch_env!("DB_PASSWORD_EVENTSTORE"),
  database: System.fetch_env!("DB_NAME_EVENTSTORE"),
  hostname: "localhost",
  pool_size: 10

config :hand_cut, HandCut.Projections.Repo,
  username: "postgres",
  password: System.fetch_env!("DB_PASSWORD_PROJECTIONS"),
  database: System.fetch_env!("DB_NAME_PROJECTIONS"),
  hostname: "localhost",
  pool_size: 10

