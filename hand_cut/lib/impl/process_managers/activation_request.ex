defmodule HandCut.ProcessManagers.ActivationRequestProcessManager do
  use Commanded.ProcessManagers.ProcessManager,
  application: HandCut.Runtime.App,
  name: "ActivationRequestProcessManager"

  @derive Jason.Encoder

  defstruct [
    :restaurant_id,
  ]

  alias HandCut.Commands.{ActivateRestaurant, ApproveActivationRequest, CreateActivationRequest}
  alias HandCut.Events.{ActivationRequestApproved, RestaurantCreated, RestaurantActivated}
  alias HandCut.ProcessManagers.ActivationRequestProcessManager

  # Process routing

  def interested?(%RestaurantCreated{id: restaurant_code}), do: {:start, restaurant_code}
  def interested?(%ActivationRequestApproved{restaurant_code: restaurant_code}), do: {:continue, restaurant_code}
  def interested?(%RestaurantActivated{id: restaurant_code}), do: {:stop, restaurant_code}

  # Command dispatch

  def handle(%ActivationRequestProcessManager{}, %RestaurantCreated{id: restaurant_code} = event) do
    %CreateActivationRequest{restaurant_code: restaurant_code}
  end

  def handle(%ActivationRequestProcessManager{}, %ActivationRequestApproved{restaurant_code: restaurant_code} = event) do
    %ActivateRestaurant{id: restaurant_code}
  end

end
