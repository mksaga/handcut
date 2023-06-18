defmodule HandCut.Restaurant.Areas do
  alias HandCut.Restaurant.Areas

  def all_area_atoms() do
   all_areas()
   |> Enum.map(&(elem(&1, 1)))
  end

  def all_areas() do
    Enum.reduce([Areas.nj(), Areas.ny(), Areas.tx()], fn x, acc -> x ++ acc end)
  end

  def humanize_area(a) do
    case a do
      a when a in [:nj_newark, "nj_newark"] -> "Newark"
      a when a in [:nj_paramus, "nj_paramus"] -> "Paramus"
      a when a in [:nj_paterson, "nj_paterson"] -> "Paterson"
      a when a in [:nj_jersey_city, "nj_jersey_city"] -> "Jersey City"
      a when a in [:ny_brooklyn, "ny_brooklyn"] -> "Brooklyn"
      a when a in [:tx_irving, "tx_irving"] -> "Irving"
    end
  end

  def nj() do
    [
      {"(NJ) Newark", :nj_newark},
      {"(NJ) Paramus", :nj_paramus},
      # {"(NJ) Ridgewood", :nj_ridgewood},
      {"(NJ) Paterson", :nj_paterson},
      {"(NJ) Jersey City", :nj_jersey_city},
    ]
  end

  def ny() do
    [
      {"(NY) Brooklyn", :ny_brooklyn},
      {"(NY) Manhattan", :ny_manhattan},
    ]
  end

  def tx() do
    [
      {"(TX) Irving", :tx_irving},
    ]
  end
end
