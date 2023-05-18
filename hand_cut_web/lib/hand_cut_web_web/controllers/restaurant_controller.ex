defmodule HandCutWebWeb.RestaurantController do
  use HandCutWebWeb, :controller
  alias HandCut.Restaurant.{Cuisines, Areas}

  def show(conn, params) do
    IO.inspect params["code"]
    render(conn, "restaurant.html")
  end
end
