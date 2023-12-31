import Config
# import HandCutWeb.ConfigHelpers, only: [get_env: 3]


config :hand_cut_web, :maps_api_key, System.fetch_env!("MAPS_API_KEY")
config :hand_cut_web, :live_view_signing_salt, System.fetch_env!("LIVE_VIEW_SIGNING_SALT")

config :esbuild, version: "0.14.41"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures the endpoint
config :hand_cut_web, HandCutWebWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: HandCutWebWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: HandCutWeb.PubSub,
  live_view: [signing_salt: Application.get_env(:hand_cut_web, :live_view_signing_salt)]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :hand_cut_web, HandCutWeb.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]


config :dart_sass,
  version: "1.61.0",
  default: [
    # args: ~w(css/app.scss ../priv/static/assets/app.css),
    args: ~w(--load-path=../deps/bulma css:../priv/static/assets),
    cd: Path.expand("../assets", __DIR__)
  ]


# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with esbuild to bundle .js and .css sources.
config :hand_cut_web, HandCutWebWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [port: 4000, ip: {127, 0, 0, 1} ],
  https: [port: 4040],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "W320INgw+wyjSAhdYCGrTIc+1lzQVsBFdxGhI8Tg7mHvThJjEcp4Ktem7nHseBT/",
  watchers: [
    # Start the esbuild watcher by calling Esbuild.install_and_run(:default, args)
    esbuild: {Esbuild, :install_and_run, [:default, ~w(--sourcemap=inline --watch)]},
    sass: {
      DartSass,
      :install_and_run,
      [:default, ~w(--embed-source-map --source-map-urls=absolute --watch)]
    }
  ]

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# Mix task:
#
#     mix phx.gen.cert
#
# Note that this task requires Erlang/OTP 20 or later.
# Run `mix help phx.gen.cert` for more information.
#
# The `http:` config above can be replaced with:
#
#     https: [
#       port: 4001,
#       cipher_suite: :strong,
#       keyfile: "priv/cert/selfsigned_key.pem",
#       certfile: "priv/cert/selfsigned.pem"
#     ],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Watch static and templates for browser reloading.
config :hand_cut_web, HandCutWebWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/.*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/hand_cut_web_web/(live|views)/.*(ex)$",
      ~r"lib/hand_cut_web_web/templates/.*(eex)$"
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
