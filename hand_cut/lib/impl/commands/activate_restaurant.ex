defmodule HandCut.Commands.ActivateRestaurant do
  @enforce_keys [:id]
  defstruct [
    :id,
    :activated_at,
  ]
end
