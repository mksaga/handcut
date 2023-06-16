import Config

config :phoenix, :json_library, Jason
config :dart_sass, :version, "1.61.0"

# config :hand_cut_web, :live_view_signing_salt, System.fetch_env!("LIVE_VIEW_SIGNING_SALT")
# config :hand_cut_web, :maps_api_key, System.fetch_env!("MAPS_API_KEY")
# config :hand_cut_web, :secret_key_base, System.fetch_env!("SECRET_KEY_BASE")


config :hand_cut_web, HandCutWebWeb.Endpoint,
  live_view: [signing_salt: Application.get_env(:hand_cut_web, :live_view_signing_salt)]
