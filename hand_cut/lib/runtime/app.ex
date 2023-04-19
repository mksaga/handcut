defmodule HandCut.Runtime.App do
  use Commanded.Application,
    otp_app: :hand_cut,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: HandCut.EventStore
    ]

  router HandCut.Router
end
