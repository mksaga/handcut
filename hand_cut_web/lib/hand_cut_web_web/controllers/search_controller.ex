defmodule HandCutWebWeb.SearchController do
  use HandCutWebWeb, :controller

  def locations() do
    [
      %{
        value: "nj_newark",
        label: "(NJ) Newark"
      },
      %{
        value: "nj_jersey_city",
        label: "(NJ) Jersey City"
      }
    ]
  end

  def cuisines() do
    [
      %{
        value: "bengali",
        label: "Bengali"
      },
      %{
        value: "mediterranean",
        label: "Mediterranean"
      },
    ]
  end

  def search(conn, _params) do
    render(conn, "search.html", locations: locations(), cuisines: cuisines())
  end
end
