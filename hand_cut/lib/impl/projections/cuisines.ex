defmodule HandCut.Restaurant.Cuisines do
  alias HandCut.Restaurant.Cuisines

  def all_cuisine_atoms() do
    all_cuisines()
    |> Enum.map(&(elem(&1, 1)))
  end

  def all_cuisines() do
    Enum.reduce(
      [
        Cuisines.east_asian(),
        Cuisines.other(),
        Cuisines.middle_eastern(),
        Cuisines.southeast_asian()
      ], fn x, acc -> x ++ acc end)
  end

  def other() do
    [
      {"American", :american},
      {"Mexican", :mexican},
    ]
  end

  def east_asian() do
    [
      {"Chinese", :chinese},
    ]
  end

  def middle_eastern() do
    [
      {"Turkish", :turkish},
      {"Middle Eastern", :middle_eastern},
    ]
  end

  def southeast_asian() do
    [
      {"Bengali", :bengali},
      {"Thai", :thai},
      {"Pakistani", :pakistani},
      {"Afghani", :afghani},
      {"Indian", :indian},
    ]
  end
end
