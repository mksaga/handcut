import Config

 config :hand_cut, event_stores: [HandCut.EventStore]

 import_config "#{config_env()}.exs"
