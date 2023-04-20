defmodule HandCut.Restaurant.Areas do
  alias HandCut.Restaurant.Areas

  def all_areas() do
    Enum.reduce([Areas.nj(), Areas.ny()], fn x, acc -> x ++ acc end)
  end

  def nj() do
    [
      :nj_newark,
      :nj_paramus,
      :nj_ridgewood,
      :nj_cliffside_park,
      :nj_paterson,
      :nj_jersey_city
    ]
  end

  def ny() do
    [
      :ny_brooklyn,
    ]
  end
end
