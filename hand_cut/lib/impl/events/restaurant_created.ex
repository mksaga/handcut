defmodule HandCut.Events.RestaurantCreated do
  @derive Jason.Encoder

  defstruct [
    :name,
    :id,
    :address,
    :phone,
    :cash_only,
    :area,
    :cuisine,
    :url,
    :latitude,
    :longitude,
    :instagram,
    :google_maps,
  ]
end
