defmodule HandCut.Events.RestaurantActivated do
  @derive Jason.Encoder

  defstruct [
    :id,
    :activated_at,
  ]
end

defimpl Commanded.Serialization.JsonDecoder, for: HandCut.Events.RestaurantActivated do
  @doc """
  Parse the datetime included
  """
  def decode(%HandCut.Events.RestaurantActivated{activated_at: datetime} = event) do
    {:ok, dt, _} = DateTime.from_iso8601(datetime)
    truncated = DateTime.truncate(dt, :second)
    %HandCut.Events.RestaurantActivated{event | activated_at: truncated}
  end
end
