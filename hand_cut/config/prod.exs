import Config

 config :hand_cut, HandCut.EventStore,
   serializer: Commanded.Serialization.JsonSerializer,
   database: "eventstore",
   username: "postgres",
    password: "g@ZqD/:R&~>6c_`g",
   hostname: "localhost",
   pool_size: 10

config :hand_cut, HandCut.Projections.Repo,
    username: "postgres",
    password: "g@ZqD/:R&~>6c_`g",
    database: "projections",
    hostname: "localhost",
    pool_size: 10
