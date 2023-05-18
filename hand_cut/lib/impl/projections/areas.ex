defmodule HandCut.Restaurant.Areas do
  alias HandCut.Restaurant.Areas

  def all_areas() do
    Enum.reduce([Areas.nj(), Areas.ny()], fn x, acc -> x ++ acc end)
  end

  def nj() do
    [
      {"(NJ) Newark", :nj_newark},
      {"(NJ) Paramus", :nj_paramus},
      {"(NJ) Ridgewood", :nj_ridgewood},
      {"(NJ) Paterson", :nj_cliffside_park},
      {"(NJ) Jersey City", :nj_jersey_city},
    ]
  end

  def ny() do
    [
      {"(NY) Brooklyn", :ny_brooklyn},
    ]
  end
end
