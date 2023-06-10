import Config

config :hand_cut, event_stores: [HandCut.EventStore]

config :nanoid,
  size: 6,
  alphabet: "0123456789abcdefghijklmnopqrstuvwxyz"

config :hand_cut, ecto_repos: [HandCut.Projections.Repo]

import_config "#{config_env()}.exs"
