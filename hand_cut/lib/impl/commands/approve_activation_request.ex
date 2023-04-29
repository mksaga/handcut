defmodule HandCut.Commands.ApproveActivationRequest do
  @enforce_keys [:restaurant_code]
  defstruct [
    :restaurant_code,
  ]
end
