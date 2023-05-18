defmodule HandCutWebWeb.RestaurantController do
  use HandCutWebWeb, :controller
  alias HandCut.Projections.Restaurant
  alias HandCut.Restaurant.{Cuisines, Areas}

  def show(conn, params) do
    IO.inspect params["code"]
    restaurant = Restaurant.get_code(params["code"])
    render(conn, "restaurant.html", restaurant: restaurant)
  end
end
