defmodule HandCut.Aggregates.ActivationRequest do
  defstruct [
    :restaurant_code,
  ]

  alias HandCut.Aggregates.ActivationRequest
  alias HandCut.Commands.{ApproveActivationRequest}
  alias HandCut.Events.{ActivationRequestApproved}

  # Public API

  def execute(%ActivationRequest{restaurant_code: code}, %ApproveActivationRequest{restaurant_code: code}) do
    {:ok, %ActivationRequestApproved{restaurant_code: code, approved_at: DateTime.now("Etc/UTC")}}
  end
end
