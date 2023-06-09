defmodule HandCut.Projectors.RestaurantProjector do

  alias HandCut.Projections.Restaurant
  alias HandCut.Events.{RestaurantCreated, RestaurantActivated}

  use Commanded.Projections.Ecto,
    application: HandCut.Runtime.App,
    repo: HandCut.Projections.Repo,
    name: "restaurant"

  project(
    %RestaurantCreated{} = event,
    _metadata,
    fn multi ->
      Ecto.Multi.insert(
        multi,
        :restaurant,
        Restaurant.changeset(
          %Restaurant{},
          %{
            name: event.name,
            code: event.id,
            active: false,
            activated_at: nil,
            address: event.address,
            cash_only: event.cash_only,
            phone: event.phone,
            area: event.area,
            cuisine: event.cuisine,
            url: event.url,
            instagram: event.instagram,
            google_maps: event.google_maps
          }
        )
      )
    end
  )

  project(
    %RestaurantActivated{
      id: code,
      activated_at: activated_at
    },
    _metadata,
    fn multi ->
      Ecto.Multi.update(
        multi,
        :restaurant,
        Restaurant.activate_changeset(
          HandCut.Projections.Repo.get_by(Restaurant, code: code),
          %{
            activated_at: activated_at,
            active: true,
          }
        )
      )
    end
  )
end
