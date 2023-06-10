defimpl HandCut.Middleware.CommandValidation, for: HandCut.Commands.CreateCertification do
  alias HandCut.Commands.CreateCertification
  alias HandCut.Projections.Restaurant

  @doc """
  Return error if restaurant ID in command doesn't exist
  """
  def validate(%CreateCertification{restaurant_id: restaurant_id} = command) do
    check_restaurant_id_exists(restaurant_id, command)
  end

  defp check_restaurant_id_exists(restaurant_id, command) do
    case Restaurant.get_by_code(restaurant_id) do
      %Restaurant{code: ^restaurant_id} -> {:ok, command}
      nil -> {:error, {:restaurant_id_not_found, restaurant_id}}
    end
  end
end
