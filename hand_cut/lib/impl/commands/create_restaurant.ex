defmodule HandCut.Commands.CreateRestaurant do
  # @derive {Inspect, only: [:name, :address, :area]}
  defstruct [
    :name,
    :id,
    :address,
    :phone,
    :area,
    :cash_only,
    :cuisine,
    :url,
    :latitude,
    :longitude,
    :instagram,
    :google_maps
  ]
end
