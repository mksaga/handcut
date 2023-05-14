defmodule HandCutWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      HandCutWebWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: HandCutWeb.PubSub},
      # Start the Endpoint (http/https)
      HandCutWebWeb.Endpoint
      # Start a worker by calling: HandCutWeb.Worker.start_link(arg)
      # {HandCutWeb.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: HandCutWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    HandCutWebWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
