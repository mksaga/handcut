defmodule HandCut.Restaurant.Cuisines do
  alias HandCut.Restaurant.Cuisines

  def all_cuisines() do
    Enum.reduce(
      [
        Cuisines.east_asian(),
        Cuisines.southeast_asian()
      ], fn x, acc -> x ++ acc end)
  end

  def east_asian() do
    [
      :asian,
      :korean,
      :japanese,
      :thai
    ]
  end

  def southeast_asian() do
    [
      :bengali,
      :pakistani,
      :desi,
      :indian
    ]
  end
end
