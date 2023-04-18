defmodule HandCut.Runtime.Application do
  use Commanded.Application,
    otp_app: :hand_cut,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: HandCut.EventStore
    ]

  def start(_type, _args) do
    # Handcut.Runtime.Server.start_link()
    Agent.start_link(fn _ -> end)
  end
end
