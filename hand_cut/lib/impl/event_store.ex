defmodule HandCut.EventStore do
  use EventStore, otp_app: :hand_cut

  # Optional `init/1` function to modify config at runtime.
  def init(config) do
    {:ok, config}
  end
end
