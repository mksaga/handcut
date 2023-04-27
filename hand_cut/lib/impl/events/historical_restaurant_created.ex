defmodule RestaurantCreated do
  @derive Jason.Encoder

  defstruct [
    :name,
    :id,
    :address,
    :phone,
    :area,
    :cuisine,
    :url,
    :instagram,
    :google_maps,
  ]
end
