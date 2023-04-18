import Config

 config :hand_cut, HandCut.EventStore,
   serializer: Commanded.Serialization.JsonSerializer,
   username: "postgres",
   password: "postgres",
   database: "eventstore_dev",
   hostname: "localhost",
   pool_size: 10
