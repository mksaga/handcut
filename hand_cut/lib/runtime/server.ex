defmodule HandCut.Runtime.Server do
  def start_link do
    children = [
      HandCut.EventStore,
      Nanoid,
    ]

    opts = [strategy: :one_for_one, name: HandCut.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
