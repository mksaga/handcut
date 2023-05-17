defmodule HandCut.Restaurant.Areas do
  alias HandCut.Restaurant.Areas

  def all_areas() do
    Enum.reduce([Areas.nj(), Areas.ny()], fn x, acc -> x ++ acc end)
  end

  def nj() do
    [
      %{value: :nj_newark, state: "NJ", name: "Newark"},
      %{value: :nj_paramus, state: "NJ", name: "Paramus"},
      %{value: :nj_ridgewood, state: "NJ", name: "Ridgewood"},
      %{value: :nj_cliffside_park, state: "NJ", name: "Cliffside Park"},
      %{value: :nj_paterson, state: "NJ", name: "Paterson"},
      %{value: :nj_jersey_city, state: "NJ", name: "Jersey City"},
    ]
  end

  def ny() do
    [
      # %{value: :ny_brooklyn, state: "NY", name: "Brooklyn"},
    ]
  end
end
