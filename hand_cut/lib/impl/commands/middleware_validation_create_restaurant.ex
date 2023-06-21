defimpl HandCut.Middleware.CommandValidation, for: HandCut.Commands.CreateRestaurant do
  alias HandCut.Commands.CreateRestaurant
  alias HandCut.Projections.Restaurant
  alias HandCut.Restaurant.{Areas, Cuisines}

  @doc """
  Return error if cuisine or area in command doesn't exist
  """
  def validate(%CreateRestaurant{id: restaurant_id, area: area, cuisine: cuisine} = command) do
    restaurant_id
    |> check_restaurant_id_valid(command)
    |> check_area_valid()
    |> check_cuisine_valid()
  end

  defp check_restaurant_id_valid(restaurant_id, command) do
    case String.starts_with?(restaurant_id, "restaurant_") do
      true -> {:ok, command}
      false -> {:error, :restaurant_id_format_invalid}
    end
  end

  defp check_area_valid({:error, _} = result), do: result
  defp check_area_valid({:ok, command}) do
    case Enum.member?(Areas.all_area_atoms(), command.area) do
      true -> case Areas.humanize_area(command.area) do
        "" -> {:error, :area_not_humanized}
        _ -> {:ok, command}
      end
      false -> {:error, :area_not_valid}
    end
  end

  defp check_cuisine_valid({:error, _} = result), do: result
  defp check_cuisine_valid({:ok, command}) do
    case Enum.member?(Cuisines.all_cuisine_atoms(), command.cuisine) do
      true -> {:ok, command}
      false -> {:error, :cuisine_not_valid}
    end
  end
end
