import Config

 config :hand_cut, HandCut.EventStore,
   serializer: Commanded.Serialization.JsonSerializer,
   username: "postgres",
   password: "postgres",
   database: "eventstore_dev",
   hostname: "localhost",
   pool_size: 10

config :hand_cut, HandCut.Projections.Repo,
  database: "hand_cut_projections",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"
