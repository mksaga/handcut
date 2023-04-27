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
    :instagram,
    :google_maps,
  ]

  defimpl Commanded.Event.Upcaster, for: RestaurantCreated do
    def upcast(%RestaurantCreated{} = event, _metadata) do
      %RestaurantCreated{
        id: id,
        name: name,
        address: address,
        phone: phone,
        area: area,
        cuisine: cuisine,
        url: url,
        instagram: instagram,
        google_maps: google_maps
        } = event

      %HandCut.Events.RestaurantCreated{
        id: id,
        name: name,
        address: address,
        phone: phone,
        cash_only: false,
        area: area,
        cuisine: cuisine,
        url: url,
        instagram: instagram,
        google_maps: google_maps
        }
    end
  end
end
