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
      a when a in [:nj_paterson, "nj_paterson"] -> "Paterson"
      a when a in [:nj_jersey_city, "nj_jersey_city"] -> "Jersey City"
      a when a in [:nj_hackensack, "nj_hackensack"] -> "Hackensack"
      a when a in [:ny_brooklyn, "ny_brooklyn"] -> "Brooklyn"
      a when a in [:ny_queens, "ny_queens"] -> "Queens"
      a when a in [:ny_manhattan, "ny_manhattan"] -> "Manhattan"
      a when a in [:tx_irving, "tx_irving"] -> "Irving"
      a when a in [:tx_plano, "tx_plano"] -> "Plano"
      a when a in [:tx_richardson, "tx_richardson"] -> "Richardson"
      _ -> ""
    end
  end

  def nj() do
    [
      {"(NJ) Newark", :nj_newark},
      {"(NJ) Hackensack", :nj_hackensack},
      {"(NJ) Paterson", :nj_paterson},
      {"(NJ) Jersey City", :nj_jersey_city},
    ]
  end

  def ny() do
    [
      {"(NY) Brooklyn", :ny_brooklyn},
      {"(NY) Queens", :ny_queens},
      {"(NY) Manhattan", :ny_manhattan},
    ]
  end

  def tx() do
    [
      {"(TX) Irving", :tx_irving},
      {"(TX) Richardson", :tx_richardson},
      {"(TX) Plano", :tx_plano},
    ]
  end
end
