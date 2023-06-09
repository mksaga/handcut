defmodule HandCut.Events.RestaurantCertificationCreated do
  @derive Jason.Encoder

  defstruct [
    :id,
    :restaurant_id,
    :type,
    :products,
    :expiration,
    :issuing_agency
  ]
end
