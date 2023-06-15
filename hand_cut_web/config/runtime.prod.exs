import Config

config :hand_cut_web, :maps_api_key, System.fetch_env!("MAPS_API_KEY")


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
  url: [host: host, port: 443, scheme: "https"],
  http: [
    # Enable IPv6 and bind on all interfaces.
    # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
    # See the documentation on https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html
    # for details about using IPv6 vs IPv4 and loopback vs public addresses.
    ip: {0, 0, 0, 0, 0, 0, 0, 0},
    port: port
  ],
  secret_key_base: secret_key_base

#   # ## Configuring the mailer
#   #
#   # In production you need to configure the mailer to use a different adapter.
#   # Also, you may need to configure the Swoosh API client of your choice if you
#   # are not using SMTP. Here is an example of the configuration:
#   #
#   #     config :hand_cut_web, HandCutWeb.Mailer,
#   #       adapter: Swoosh.Adapters.Mailgun,
#   #       api_key: System.get_env("MAILGUN_API_KEY"),
#   #       domain: System.get_env("MAILGUN_DOMAIN")
#   #
#   # For this example you need include a HTTP client required by Swoosh API client.
#   # Swoosh supports Hackney and Finch out of the box:
#   #
#   #     config :swoosh, :api_client, Swoosh.ApiClient.Hackney
#   #
#   # See https://hexdocs.pm/swoosh/Swoosh.html#module-installation for details.
