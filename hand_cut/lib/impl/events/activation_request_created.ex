defmodule HandCut.Events.ActivationRequestCreated do
  @derive Jason.Encoder

  defstruct [
    :restaurant_code,
  ]
end
