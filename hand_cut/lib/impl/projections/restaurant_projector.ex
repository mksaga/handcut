defmodule HandCut.Projectors.RestaurantProjector do
  alias HandCut.Restaurant

  use Commanded.Projections.Ecto,
    application: HandCut.Runtime.App,
    repo: HandCut.Projections.Repo,
    name: "restaurant"

  project(
    %HandCut.Events.RestaurantCreated{
      name: name,
      id: code,
      address: address,
      cash_only: cash_only,
      phone: phone,
      area: area,
      cuisine: cuisine,
      url: url,
      instagram: instagram,
      google_maps: google_maps
    },
    _metadata,
    fn multi ->
      Ecto.Multi.insert(
        multi,
        :restaurant,
        Restaurant.changeset(
          %Restaurant{},
          %{
            name: name,
            code: code,
            active: false,
            activated_at: nil,
            address: address,
            cash_only: cash_only,
            phone: phone,
            area: area,
            cuisine: cuisine,
            url: url,
            instagram: instagram,
            google_maps: google_maps
          }
        )
      )
    end
  )
end
