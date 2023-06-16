import Config

config :hand_cut, ecto_repos: [HandCut.Projections.Repo]
config :hand_cut, event_stores: [HandCut.EventStore]
