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
      %{value: :asian, label: "Asian"},
      %{value: :korean, label: "Korean"},
      %{value: :chinese, label: "Chinese"},
      %{value: :japanese, label: "Japanese"},
    ]
  end

  def southeast_asian() do
    [
      %{value: :bengali, label: "Bengali"},
      %{value: :thai, label: "Thai"},
      # :pakistani,
      # :desi,
      # :indian
    ]
  end
end
