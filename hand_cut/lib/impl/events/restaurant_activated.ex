defmodule HandCut.Events.RestaurantActivated do
  @derive Jason.Encoder

  defstruct [
    :id,
    :activated_at,
  ]
end
