defmodule HandCutWebWeb.SearchController do
  use HandCutWebWeb, :controller
  alias HandCut.Restaurant.{Cuisines, Areas}

  def locations() do
   Areas.all_areas()
  end

  def cuisines() do
   Cuisines.all_cuisines()
  end

  def search(conn, _params) do
    render(conn, "search.html", locations: locations(), cuisines: cuisines())
  end
end
