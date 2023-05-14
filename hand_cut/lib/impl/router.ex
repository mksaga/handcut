defmodule HandCut.Router do
  use Commanded.Commands.Router

  alias HandCut.Aggregates.{ActivationRequest, Restaurant}
  alias HandCut.Commands.{ActivateRestaurant, CreateRestaurant}
  alias HandCut.Commands.{ApproveActivationRequest, CreateActivationRequest}

  identify(Restaurant, by: :id)
  identify(ActivationRequest, by: :restaurant_code)

  dispatch [ActivateRestaurant, CreateRestaurant], to: Restaurant
  dispatch [ApproveActivationRequest, CreateActivationRequest], to: ActivationRequest
end
