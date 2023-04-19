defmodule HandCut.Router do
  use Commanded.Commands.Router

  alias HandCut.Aggregates.{Restaurant}
  alias HandCut.Commands.{CreateRestaurant}

  identify(Restaurant, by: :id)

  dispatch [CreateRestaurant], to: Restaurant
end
