defmodule HandCutWebWeb.RestaurantController do
  use HandCutWebWeb, :controller
  alias HandCut.Projections.Restaurant

  def show(conn, params) do
    restaurant = Restaurant.get_code("restaurant_" <> params["code"])
    render(conn, "restaurant.html", restaurant: restaurant)
  end
end
