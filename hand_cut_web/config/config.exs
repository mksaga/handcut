import Config

config :phoenix, :json_library, Jason
config :dart_sass, :version, "1.61.0"

config :hand_cut_web, :live_view_signing_salt, System.fetch_env!("LIVE_VIEW_SIGNING_SALT")
config :hand_cut_web, :maps_api_key, System.fetch_env!("MAPS_API_KEY")
config :hand_cut_web, :secret_key_base, System.fetch_env!("SECRET_KEY_BASE")


config :hand_cut_web, HandCutWebWeb.Endpoint,
  live_view: [signing_salt: Application.get_env(:hand_cut_web, :live_view_signing_salt)]

config :esbuild,
  version: "0.14.41",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

config :dart_sass,
  version: "1.61.0",
  default: [
    # args: ~w(css/app.scss ../priv/static/assets/app.css),
    args: ~w(--load-path=../deps/bulma css:../priv/static/assets),
    cd: Path.expand("../assets", __DIR__)
  ]
