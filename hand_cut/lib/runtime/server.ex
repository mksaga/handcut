defmodule HandCut.Runtime.Server do
  def start_link do
    children = [
      HandCut.Runtime.App,
      # HandCut.EventStore,
      # Nanoid,
      # HandCut.Runtime.Application,
      # %{
        # id: HandCut.Runtime.Application,
        # start: {HandCut.Runtime.Application, :start_link, []}
      # },
      RestaurantHandler,
    ]

    opts = [strategy: :one_for_one, name: HandCut.Supervisor]
    Supervisor.start_link(children, opts)
  end
end


# id = "restaurant_" <> Nanoid.generate()
# command = %CreateRestaurant{name: "ThaiSpot", address: "123 Main St", area: "Jersey City", cuisine: "Thai", url: "thaispot.com", instagram: "thaispot", google_maps: "google.com", id: id}
# :ok = HandCut.RestaurantRouter.dispatch(command)
