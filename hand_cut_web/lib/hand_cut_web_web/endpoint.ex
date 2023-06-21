defmodule HandCutWebWeb.Endpoint do
  use Phoenix.Endpoint, otp_app: :hand_cut_web
  use SiteEncrypt.Phoenix

  # The session will be stored in the cookie and signed,
  # this means its contents can be read but not tampered with.
  # Set :encryption_salt if you would also like to encrypt it.
  @session_options [
    store: :cookie,
    key: "_hand_cut_web_key",
    signing_salt: "c1oLLaP7"
  ]

  socket "/live", Phoenix.LiveView.Socket, websocket: [connect_info: [session: @session_options]]

  @impl SiteEncrypt
  def certification do
    SiteEncrypt.configure(
      # Note that native client is very immature. If you want a more stable behaviour, you can
      # provide `:certbot` instead. Note that in this case certbot needs to be installed on the
      # host machine.
      client: :native,

      domains: ["handcut.net", "www.handcut.net"],
      emails: ["handcutapp@gmail.com"],

      # By default the certs will be stored in tmp/site_encrypt_db, which is convenient for
      # local development. Make sure that tmp folder is gitignored.
      #
      # Set OS env var SITE_ENCRYPT_DB on staging/production hosts to some absolute path
      # outside of the deployment folder. Otherwise, the deploy may delete the db_folder,
      # which will effectively remove the generated key and certificate files.
      db_folder:
        System.get_env("SITE_ENCRYPT_DB", Path.join("tmp", "site_encrypt_db")),

      # set OS env var CERT_MODE to "staging" or "production" on staging/production hosts
      directory_url:
        case System.get_env("CERT_MODE", "local") do
          "local" -> {:internal, port: 4002}
          "staging" -> "https://acme-staging-v02.api.letsencrypt.org/directory"
          "production" -> "https://acme-v02.api.letsencrypt.org/directory"
        end
    )
  end

  @impl Phoenix.Endpoint
  def init(_key, config) do
    # this will merge key, cert, and chain into `:https` configuration from config.exs
    {:ok, SiteEncrypt.Phoenix.configure_https(config)}

    # to completely configure https from `init/2`, invoke:
    #   SiteEncrypt.Phoenix.configure_https(config, port: 4001, ...)
  end

  def www_redirect(conn, _options) do
    if String.starts_with?(conn.host, "www.#{host()}") do
      conn
      |> Phoenix.Controller.redirect(external: "https://#{host()}")
      |> halt()
    else
      conn
    end
  end


  # Redirect all www requests to the root url
  plug :www_redirect

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phx.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/",
    from: :hand_cut_web,
    gzip: false,
    only: ~w(assets fonts images favicon.ico apple-touch-icon.png favicon-32x32.png favicon-16x16.png robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Phoenix.LiveDashboard.RequestLogger,
    param_key: "request_logger",
    cookie_key: "request_logger"

  plug Plug.RequestId
  plug Plug.Telemetry, event_prefix: [:phoenix, :endpoint]

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Phoenix.json_library()

  plug Plug.MethodOverride
  plug Plug.Head
  plug Plug.Session, @session_options
  plug HandCutWebWeb.Router
end
