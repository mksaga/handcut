defmodule HandCut.Commands.UpdateRestaurant do
  # @derive {Inspect, only: [:name, :address, :area]}
  defstruct [
    :id,
    :name,
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
