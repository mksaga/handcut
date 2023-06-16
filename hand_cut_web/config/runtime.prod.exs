import Config

config :hand_cut_web, :maps_api_key, System.fetch_env!("MAPS_API_KEY")
config :hand_cut_web, :live_view_signing_salt, System.fetch_env!("LIVE_VIEW_SIGNING_SALT")


# ## Using releases
#
# If you use `mix release`, you need to explicitly enable the server
# by passing the PHX_SERVER=true when you start it:
#
#     PHX_SERVER=true bin/hand_cut_web start
#
# Alternatively, you can use `mix phx.gen.release` to generate a `bin/server`
# script that automatically sets the env var above.
if System.get_env("PHX_SERVER") do
  config :hand_cut_web, HandCutWebWeb.Endpoint, server: true
end

# The secret key base is used to sign/encrypt cookies and other secrets.
# A default value is used in config/dev.exs and config/test.exs but you
# want to use a different value for prod and you most likely don't want
# to check this value into version control, so we use an environment
# variable instead.
secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

host = System.get_env("PHX_HOST") || "example.com"
port = String.to_integer(System.get_env("HTTP_PORT") || "4000")


config :hand_cut_web, HandCutWebWeb.Endpoint,
  url: [host: "handcut.net", port: 443],
  cache_static_manifest: "priv/static/cache_manifest.json",
  live_view: [signing_salt: Application.get_env(:hand_cut_web, :live_view_signing_salt)],
  server: true,
  force_ssl: [hsts: true],
  http: [port: 4000, transport_options: [socket_opts: [:inet6]]],
  https: [
    port: 4040,
    cipher_suite: :strong,
    transport_options: [socket_opts: [:inet6]]
  ]

# Set path to cert folder
config :hand_cut_web, :cert_path, "/home/mohamedaly/site_encrypt_db"

# Set the cert mode so site_encrypt knows to hit live LetsEncrypt
config :hand_cut_web, :cert_mode, "production"

config :dart_sass, :version, "1.61.0"
