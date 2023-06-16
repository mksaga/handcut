import Config

config :phoenix, :json_library, Jason
config :dart_sass, :version, "1.61.0"


config :hand_cut_web, HandCutWebWeb.Endpoint,
  live_view: [signing_salt: Application.get_env(:hand_cut_web, :live_view_signing_salt)],
