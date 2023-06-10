defmodule HandCut.Router do
  use Commanded.Commands.Router

  alias HandCut.Aggregates.{ActivationRequest, Certification, Restaurant}
  alias HandCut.Commands.{ActivateRestaurant, CreateRestaurant}
  alias HandCut.Commands.{CreateCertification}
  alias HandCut.Commands.{ApproveActivationRequest, CreateActivationRequest}
  alias HandCut.Middleware.ValidateCommand

  middleware ValidateCommand

  identify(Restaurant, by: :id)
  identify(Certification, by: :id)
  identify(ActivationRequest, by: :restaurant_code)

  dispatch [ActivateRestaurant, CreateRestaurant], to: Restaurant
  dispatch [ApproveActivationRequest, CreateActivationRequest], to: ActivationRequest
  dispatch CreateCertification, to: Certification
end
