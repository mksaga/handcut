defmodule HandCut.Events.ActivationRequestApproved do
  @derive Jason.Encoder

  defstruct [
    :restaurant_code,
    :approved_at,
  ]
end
